#!/usr/bin/env python
import sys
import struct
import os
import argparse
import socket
import random
import argparse
import time
import gpt2

from scapy.all import sniff, send, sendp, hexdump, get_if_list, get_if_hwaddr, hexdump, sr1,sr
from scapy.all import Packet, IPOption
from scapy.all import ShortField, IntField, LongField, BitField, FieldListField, FieldLenField
from scapy.all import IP, IPv6, TCP, UDP, Raw, Ether
from scapy.layers.inet import _IPOption_HDR
from gpt2 import *
from scapy import all

class dl_pdu_session(Packet):
        name = "DL PDU Session"
	fields_desc = [ BitField("gtp_ext", 0,8),	
			BitField("PDU_type",0,4),
			BitField("Spare",0,5),
			BitField("RQI",0,1),
			BitField("QoSID",0,6),
			BitField("padding",0,8),	
			]
        def extract_padding(self, p):
            return "", p

def get_if():
    ifs=get_if_list()
    iface=None
    for i in get_if_list():
        if "eth1" in i:
            iface=i
            break;
    if not iface:
        print "Cannot find eth1 interface"
        exit(1)
    return iface

class IPOption_MRI(IPOption):
    name = "MRI"
    option = 31
    fields_desc = [ _IPOption_HDR,
                    FieldLenField("length", None, fmt="B",
                                  length_of="swids",
                                  adjust=lambda pkt,l:l+4),
                    ShortField("count", 0),
                    FieldListField("swids",
                                   [],
                                   IntField("", 0),
                                   length_from=lambda pkt:pkt.count*4) ]
                                
def handle_pkt(pkt):
    iface = "eth2"
    #if UDP in pkt and pkt[UDP].dport == 2152:
    #if UDP in pkt:
    #if pkt.nh == 43:
    #    print "wow, got a srv6 packet"
    #    pkt.addresses=["fc00::4","fc00::1","fc00::99"]
    

    print "got a packet"
    pkt.show()
    #hexdump(pkt) 

    #5G PACKET
    pkt5g =  Ether(src='00:15:5d:00:00:00', dst='00:15:5d:00:00:04') / IPv6(src="fc00::1", dst="fc00::5") /  IPv6ExtHdrRouting(type = 4, segleft = 2, addresses=["fc00::5","fc00::101","fc00::100"]) / UDP (sport=64515, dport=2152 ) / GTP_U_Header(TEID=32, Reserved=0, E=1) / dl_pdu_session(gtp_ext=133,QoSID=14)

    #Full packet (5G + USER DATA)
    pkt2=pkt5g / pkt[IPv6]
    
    print "packet sent"
    pkt2.show()
    #hexdump(pkt2)
    sendp(pkt2, iface="eth1", verbose=False)
    pkt3=pkt2[dl_pdu_session]
    pkt4=pkt3[IPv6]
    pkt4.show()
    main()

def main():
    bind_layers(GTP_U_Header, dl_pdu_session, E = 1 )
    ifaces = filter(lambda i: 'eth' in i, os.listdir('/sys/class/net/'))
    iface = "eth2"
    print "sniffing on %s" % iface
    sys.stdout.flush()
    sniff(iface = iface,
          prn = lambda x: handle_pkt(x))
    print "teste"

if __name__ == '__main__':
    main()