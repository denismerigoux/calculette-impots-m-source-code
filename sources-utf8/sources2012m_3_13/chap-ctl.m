#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2013 
#au titre des revenus percus en 2012. La présente version a permis la 
#génération du moteur de calcul des chaînes de taxation des rôles d'impôt 
#sur le revenu de ce millésime.
#
#Ce logiciel est régi par la licence CeCILL 2.1 soumise au droit français 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusée par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accéder à cet en-tête signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accepté les termes.
#
#**************************************************************************************************************************
regle corrective base_tl_init 1202:
application :  iliad ;


TL_MF = IND_TL_MF;
RNI_INIT = RNI ;
ETR_INIT = IPMOND + IPTXMO ;
EFF_INIT = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	   + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	   + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	   + IPMOND + IPTXMO ;
PVQ_INIT = TTPVQ ;
PV_INIT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV ;
RI_INIT  = (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_INIT = BCSG ;
BRDS_INIT = BRDS ;
BPRS_INIT = BPRS ;
TAXAGA_INIT = BASSURV + BASSURC ;
PCAP_INIT = BPCAPTAXV + BPCAPTAXC ;
LOY_INIT = LOYELEV ;
CHR_INIT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSAL_INIT = BPVOPTCSV + BPVOPTCSC ; 
GAIN_INIT = GAINSALAV + GAINSALAC ;
CVN_INIT = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDIS_INIT = GSALV + GSALC ;
GLO_INIT = GLDGRATV + GLDGRATC ;
RSE1_INIT = BRSE1 ;
RSE2_INIT = BRSE2 ;
RSE3_INIT = BRSE3 ;
RSE4_INIT = BRSE4 ;
RSE5_INIT = BRSE5 ;

regle corrective  base_tl 1204:
application :  iliad ;


RNI_TL = RNI ;
ETR_TL = IPMOND + IPTXMO ;
EFF_TL = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	 + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	 + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	 + IPMOND + IPTXMO ;
PVQ_TL = TTPVQ ;
PV_TL  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV ;
RI_TL  = (REDTL + CIMPTL) * (1 - V_CNR) ;
RDS_TL  = BCSG ;
BRDS_TL = BRDS ;
BPRS_TL = BPRS ;
TAXAGA_TL = BASSURV + BASSURC ;
PCAP_TL = BPCAPTAXV + BPCAPTAXC ;
LOYA_TL = LOYELEV ;
CHR_TL  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSALA_TL = BPVOPTCSV + BPVOPTCSC ; 
GAINA_TL = GAINSALAV + GAINSALAC ;
CVNA_TL = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDISA_TL = GSALV + GSALC;
GLOA_TL = GLDGRATV + GLDGRATC ;
RSE1A_TL = BRSE1 ;
RSE2A_TL = BRSE2 ;
RSE3A_TL = BRSE3 ;
RSE4A_TL = BRSE4 ;
RSE5A_TL = BRSE5 ;

regle corrective base_tl_rect 1206:
application :  iliad ;


RNI_RECT = RNI ;
ETR_RECT = IPMOND + IPTXMO ;
EFF_RECT = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	   + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	   + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	   + IPMOND + IPTXMO ;
PVQ_RECT = TTPVQ ;
PV_RECT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV ;
RI_RECT  = RI_INIT - (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_RECT = BCSG ;
BRDS_RECT = BRDS ;
BPRS_RECT = BPRS ;
TAXAGA_RECT = BASSURV + BASSURC ;
PCAP_RECT = BPCAPTAXV + BPCAPTAXC ;
LOY_RECT = LOYELEV ;
CHR_RECT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSAL_RECT = BPVOPTCSV + BPVOPTCSC ; 
GAIN_RECT = GAINSALAV + GAINSALAC ;
CVN_RECT = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDIS_RECT = GSALV + GSALC ;
GLO_RECT = GLDGRATV + GLDGRATC ;
RSE1_RECT = BRSE1 ;
RSE2_RECT = BRSE2 ;
RSE3_RECT = BRSE3 ;
RSE4_RECT = BRSE4 ;
RSE5_RECT = BRSE5 ;

CSG_RECT = CSG ;
PS_RECT  = PRS ;

