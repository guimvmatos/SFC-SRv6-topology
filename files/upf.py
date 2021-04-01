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
    #    pkt.addresses=["fc00::1","fc00::1","fc00::99"]
    

    print "got a packet"
    pkt.show2()
    hexdump(pkt) 

    #5G PACKET
    pkt5g =  Ether(src='00:15:5d:00:00:04', dst='00:15:5d:00:00:00') / IPv6(src="fc00::5", dst="fc00::1") /  IPv6ExtHdrRouting(type = 4, segleft = 2, addresses=["fc00::1","fc00::101","fc00::100"]) / UDP (sport=64515, dport=2152 ) / GTP_U_Header(TEID=32, Reserved=0, E=1) / dl_pdu_session(gtp_ext=133,QoSID=14)

    #Full packet (5G + USER DATA)
    pkt2=pkt5g / pkt[IPv6]

    pkt3=pkt2[UDP]
    pkt4=pkt3[IPv6]
    print "packet clean"
    pkt4.show()

    print "packet sent"
    pkt2.show2()
    hexdump(pkt2)
    sendp(pkt2, iface="eth1", verbose=False)
    main()

def handle_pkt2(pkt):
    iface = "eth1"

    print "got a packet (ORIGINAL)"
    pkt.show2()
    hexdump(pkt) 

    pkt2=pkt[UDP]
    pkt3=pkt2[IPv6]

    print "packet clean (PKT SENT)"
    pkt3.show()
    hexdump(pkt3)
    sendp(pkt3, iface="eth2", verbose=False)
    main()

def main():
    ifaces = filter(lambda i: 'eth' in i, os.listdir('/sys/class/net/'))
    iface = "eth2"
    print "sniffing on %s" % iface
    sys.stdout.flush()
    sniff(iface = "eth2",
          prn = lambda x: handle_pkt(x))
    sniff(iface = "eth1",
          prn = lambda x: handle_pkt2(x))
    print "teste"

if __name__ == '__main__':
    main()