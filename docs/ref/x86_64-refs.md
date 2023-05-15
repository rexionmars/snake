## x86 Instruction Set Reference
CMOVcc

Conditional Move

|Opcode |Mnemonic            |Description                                 |
|-------|--------------------|--------------------------------------------|
|0F 47	|CMOVA r16, r/m16	   |Move if above (CF=0 and ZF=0).
|0F 47	|CMOVA r32, r/m32	   |Move if above (CF=0 and ZF=0).
|0F 43	|CMOVAE r16, r/m16Z  |Move if above or equal (CF=0).
|0F 43	|CMOVAE r32, r/m32	 |Move if above or equal (CF=0).
|0F 42	|CMOVB r16, r/m16	   |Move if below (CF=1).
|0F 42	|CMOVB r32, r/m32	   |Move if below (CF=1).
|0F 46	|CMOVBE r16, r/m16	 |Move if below or equal (CF=1 or ZF=1).
|0F 46	|CMOVBE r32, r/m32	 |Move if below or equal (CF=1 or ZF=1).
|0F 42	|CMOVC r16, r/m16	   |Move if carry (CF=1).
|0F 42	|CMOVC r32, r/m32	   |Move if carry (CF=1).
|0F 44	|CMOVE r16, r/m16	   |Move if equal (ZF=1).
|0F 44	|CMOVE r32, r/m32	   |Move if equal (ZF=1).
|0F 4F	|CMOVG r16, r/m16	   |Move if greater (ZF=0 and SF=OF).
|0F 4F	|CMOVG r32, r/m32	   |Move if greater (ZF=0 and SF=OF).
|0F 4D	|CMOVGE r16, r/m16	 |Move if greater or equal (SF=OF).
|0F 4D	|CMOVGE r32, r/m32	 |Move if greater or equal (SF=OF).
|0F 4C	|CMOVL r16, r/m16	   |Move if less (SF<>OF).
|0F 4C	|CMOVL r32, r/m32	   |Move if less (SF<>OF).
|0F 4E	|CMOVLE r16, r/m16	 |Move if less or equal (ZF=1 or SF<>OF).
|0F 4E	|CMOVLE r32, r/m32	 |Move if less or equal (ZF=1 or SF<>OF).
|0F 46	|CMOVNA r16, r/m16	 |Move if not above (CF=1 or ZF=1).
|0F 46	|CMOVNA r32, r/m32	 |Move if not above (CF=1 or ZF=1).
|0F 42	|CMOVNAE r16, r/m16	 |Move if not above or equal (CF=1).
|0F 42	|CMOVNAE r32, r/m32	 |Move if not above or equal (CF=1).
|0F 43	|CMOVNB r16, r/m16	 |Move if not below (CF=0).
|0F 43	|CMOVNB r32, r/m32	 |Move if not below (CF=0).
|0F 47	|CMOVNBE r16, r/m16	 |Move if not below or equal (CF=0 and ZF=0).
|0F 47	|CMOVNBE r32, r/m32	 |Move if not below or equal (CF=0 and ZF=0).
|0F 43	|CMOVNC r16, r/m16	 |Move if not carry (CF=0).
|0F 43	|CMOVNC r32, r/m32	 |Move if not carry (CF=0).
|0F 45	|CMOVNE r16, r/m16	 |Move if not equal (ZF=0).
|0F 45	|CMOVNE r32, r/m32	 |Move if not equal (ZF=0).
|0F 4E	|CMOVNG r16, r/m16	 |Move if not greater (ZF=1 or SF<>OF).
|0F 4E	|CMOVNG r32, r/m32	 |Move if not greater (ZF=1 or SF<>OF).
|0F 4C	|CMOVNGE r16, r/m16	 |Move if not greater or equal (SF<>OF.)
|0F 4C	|CMOVNGE r32, r/m32	 |Move if not greater or equal (SF<>OF).
|0F 4D	|CMOVNL r16, r/m16	 |Move if not less (SF=OF).
|0F 4D	|CMOVNL r32, r/m32	 |Move if not less (SF=OF).
|0F 4F	|CMOVNLE r16, r/m16	 |Move if not less or equal (ZF=0 and SF=OF).
|0F 4F	|CMOVNLE r32, r/m32	 |Move if not less or equal (ZF=0 and SF=OF).
|0F 41	|CMOVNO r16, r/m16	 |Move if not overflow (OF=0).
|0F 41	|CMOVNO r32, r/m32	 |Move if not overflow (OF=0).
|0F 4B	|CMOVNP r16, r/m16	 |Move if not parity (PF=0).
|0F 4B	|CMOVNP r32, r/m32	 |Move if not parity (PF=0).
|0F 49	|CMOVNS r16, r/m16	 |Move if not sign (SF=0).
|0F 49	|CMOVNS r32, r/m32	 |Move if not sign (SF=0).
|0F q5	|CMOVNZ r16, r/m16	 |Move if not zero (ZF=0).
|0F 45	|CMOVNZ r32, r/m32	 |Move if not zero (ZF=0).
|0F 40	|CMOVO r16, r/m16	   |Move if overflow (OF=1).
|0F 40	|CMOVO r32, r/m32	   |Move if overflow (OF=1).
|0F 4A	|CMOVP r16, r/m16	   |Move if parity (PF=1).
|0F 4A	|CMOVP r32, r/m32	   |Move if parity (PF=1).
|0F 4A	|CMOVPE r16, r/m16	 |Move if parity even (PF=1).
|0F 4A	|CMOVPE r32, r/m32	 |Move if parity even (PF=1).
|0F 4B	|CMOVPO r16, r/m16	 |Move if parity odd (PF=0).
|0F 4B	|CMOVPO r32, r/m32	 |Move if parity odd (PF=0).
|0F 48	|CMOVS r16, r/m16	   |Move if sign (SF=1).
|0F 48	|CMOVS r32, r/m32	   |Move if sign (SF=1).
|0F 44	|CMOVZ r16, r/m16	   |Move if zero (ZF=1).
|0F 44	|CMOVZ r32, r/m32    |Move if zero (ZF=1).
