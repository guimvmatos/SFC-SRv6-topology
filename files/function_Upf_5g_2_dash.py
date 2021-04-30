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


def downlink(pkt):
    if IPv6 in pkt: 
        if UDP in pkt and pkt[UDP].dport == 2152:
            #PAYLOAD PACKET
            #pkt.show()
            print "5G CORE TO DASH"
            data=pkt[Raw].load
            temp=dl_pdu_session(data)
            data2=temp[Padding].load
            pkt2=IPv6(data2)
            pkt3=Ether(dst="08:00:27:dd:dd:dd", src="08:00:27:aa:aa:aa") / pkt2
            pkt3.show()
            sendp(pkt3, iface="eth2", verbose=False)
          

def main():
    bind_layers(GTP_U_Header, dl_pdu_session, E = 1 )
    sniff(iface="eth1",filter="dst fc00::5", prn=lambda x: downlink(x))

if __name__ == '__main__':
    main()