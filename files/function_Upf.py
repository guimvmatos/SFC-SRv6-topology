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


def updownlink(pkt):
    if IPv6 in pkt: 
        #if GTP_U_Header in pkt:
        if UDP in pkt and pkt[UDP].dport == 2152:
            print "5G_CORE -> DN/UE"
            print "ORIGINAL PACKET"
            pkt.show()

            #PAYLOAD PACKET
            data=pkt[Raw].load
            temp=dl_pdu_session(data)
            if temp[dl_pdu_session].Spare==2:
                print "PAYLOAD PACKET"
                data2=temp[Padding].load
                pkt2=IPv6(data2)
                pkt3=Ether(dst="08:00:27:aa:aa:aa")/pkt2
                pkt3.show()
                sendp(pkt3, iface="eth2", verbose=False)
                #sys.stdout.flush()
                #main()
        else:        
            print "DN/UE -> 5G_CORE"
            print "ORIGINAL PACKET"
            pkt.show()

            #5G PACKET CONSTRUCTION
            pkt5g =  Ether(src='00:15:5d:00:00:04', dst='00:15:5d:00:00:00') / IPv6(src="fc00::5", dst="fc00::1") /  IPv6ExtHdrRouting(type = 4, segleft = 2, addresses=["fc00::1","fc00::101","fc00::100"]) / UDP (sport=64515, dport=2152 ) / GTP_U_Header(TEID=32, Reserved=0, E=1) / dl_pdu_session(gtp_ext=133,QoSID=14,Spare=1)

            #Full packet (5G + USER DATA)
            pkt2=pkt5g / pkt[IPv6]
            
            print "5G FULL PACKET"
            pkt2.show()
            sendp(pkt2, iface="eth1", verbose=False)
            #sys.stdout.flush()
            #main()

def main():
    bind_layers(GTP_U_Header, dl_pdu_session, E = 1 )
    #sniff(iface=["eth1","eth2"], prn=lambda x: x.sniffed_on+": "+x.summary())
    #sniff(iface=["eth1","eth2"], prn=lambda x: updownlink(x))
    sniff(iface="eth1",prn=lambda x: updownlink(x))
    #sys.stdout.flush()
    

if __name__ == '__main__':
    main()