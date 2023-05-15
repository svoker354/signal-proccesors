*------------------------------------------------------------------------------
* Global symbols defined here and exported out of this file
*------------------------------------------------------------------------------
	.global _vectors ;global symbols
	.global _c_int00
	.global _vector1
	.global _vector2
	.global _vector3
	.global _vector4
	.global _vector5
	.global _vector6
	.global _vector7
	.global _vector8
	.global _vector9
	.global _vector10
	.global _c_int11 ; Hookup the c_int11 ISR in main()
	.global _vector12
	.global _vector13
	.global _vector14
	.global _vector15
*------------------------------------------------------------------------------
* Global symbols referenced in this file but defined somewhere else.
* Remember that your interrupt service routines need to be referenced here.
*------------------------------------------------------------------------------
	.ref _c_int00 ;entry address
*------------------------------------------------------------------------------
* This is a macro that instantiates one entry in theinterrupt service table.
*------------------------------------------------------------------------------
RST_VEC_ENTRY .macro addr
	NOP
	MVKL addr,B0
	MVKH addr,B0
	B B0
	NOP
	NOP 2
	NOP
	NOP
	.endm
VEC_ENTRY .macro addr
	STW B0,*--B15
	MVKL addr,B0
	MVKH addr,B0
	B B0
	LDW *B15++,B0
	NOP 2
	NOP
	NOP
	.endm
*------------------------------------------------------------------------------
* This is a dummy interrupt service routine used toinitialize the IST.
*------------------------------------------------------------------------------
_vec_dummy:
	B B3
	NOP 5
*------------------------------------------------------------------------------
* This is the actual interrupt service table (IST). It isproperly aligned and
* is located in the subsection .text:vecs. This means if youdon�t explicitly
* specify this section in your linker command file, it willdefault and link
* into the .text section. Remember to set the ISTP registerto point to this
* table.
*------------------------------------------------------------------------------
	.sect ".vectors" ;aligned IST section
	.align 1024
_vectors:
_vector0: RST_VEC_ENTRY _c_int00 ;RESET
_vector1: VEC_ENTRY _vec_dummy ;NMI
_vector2: VEC_ENTRY _vec_dummy ;RSVD
_vector3: VEC_ENTRY _vec_dummy
_vector4: VEC_ENTRY _vec_dummy
_vector5: VEC_ENTRY _vec_dummy
_vector6: VEC_ENTRY _vec_dummy
_vector7: VEC_ENTRY _vec_dummy
_vector8: VEC_ENTRY _vec_dummy
_vector9: VEC_ENTRY _vec_dummy
_vector10: VEC_ENTRY _vec_dummy
_vector11: VEC_ENTRY _c_int11 ; Hookup the c_int11 ISR inmain()
_vector12: VEC_ENTRY _vec_dummy
_vector13: VEC_ENTRY _vec_dummy
_vector14: VEC_ENTRY _vec_dummy
_vector15: VEC_ENTRY _vec_dummy