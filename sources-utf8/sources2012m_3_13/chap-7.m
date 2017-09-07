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

 #
                                                                        #######
  ####   #    #    ##    #####      #     #####  #####   ######         #    #
 #    #  #    #   #  #   #    #     #       #    #    #  #                  #
 #       ######  #    #  #    #     #       #    #    #  #####             #
 #       #    #  ######  #####      #       #    #####   #                #
 #    #  #    #  #    #  #          #       #    #   #   #                #
  ####   #    #  #    #  #          #       #    #    #  ###### #######   #
 #
 #
 #
 #
 #
 #
 #
 #                           REVENU IMPOSABLE
 #
 #                           ET       CHARGES
 #
 #
 #
 #
regle 700:
application : bareme , iliad , batch  ;
pour z=1,2:
RB5z = max( 0, RB0z + TONEQUO1) ;
RB55 = max( 0, RB05 + TONEQUOM1) ;
regle 701:
application : bareme , iliad , batch  ;
RB01 = (RI1 * (1 - positif(IPTEFP + IPTEFN +INDTEFF))) 
	+ (IPTEFP + RFROBOR * V_INDTEO * present(IPTEFP))
	+TEFFREVTOT*(1-positif(IPTEFP))*INDTEFF;
RB02 = (RI2 * (1 - positif(IPTEFP + IPTEFN+ INDTEFF))) 
	+ positif(IPTEFP)*(IPTEFP +RFROBOR * V_INDTEO * present(IPTEFP)+ DPAE) 
	+ TEFFREVTOT*(1-positif(IPTEFP))*INDTEFF;
RB03 = (RI3 * (1 - positif(IPTEFP + IPTEFN+ INDTEFF))) 
	+ max( 0 , IPTEFP+RFROBOR * V_INDTEO * present(IPTEFP))
	+min(TEFFREVTOT,0) * (1-positif(IPTEFP)) * INDTEFF;
RB04 = IND_TDR;
regle 70105:
application : iliad , bareme , batch ;
RB05 = RMOND ;
RB06 = RE168+TAX1649;
regle 7011:
application : iliad , batch  ;
TONEQUO1 = somme(x=1..4:RPQx) + somme(x=V,C,1..4: RPQFx) + somme(x=V,C,1..4: RPQPALIMx) + somme(x=1,2 : RPQRFx)
	 + RPQRCMDC + RPQRCMFU  + RPQRCMCH  + RPQRCMTR  + RPQRCMTS + RPQRCMGO +somme(x=V,C,1..4 : RPQPRRx) + RPQRVO  + RPQRVO5  + RPQRVO6  + RPQRVO7
	 + somme(x=V,C,1..4 : RPQTSx) + somme(x=V,C,1..4 : RPQTSREMPx);
TONEQUOM1 = somme(x=1..4:RPQxM) + somme(x=V,C,1..4: RPQFxM) + somme(x=V,C,1..4: RPQPALIMxM) + somme(x=1,2 : RPQRFxM)
	 + RPQRCMDCM + RPQRCMFUM  + RPQRCMCHM  + RPQRCMTRM  + RPQRCMTSM + RPQRCMGOM +somme(x=V,C,1..4 : RPQPRRxM) + RPQRVOM  + RPQRVO5M  + RPQRVO6M  + RPQRVO7M
	 + somme(x=V,C,1..4 : RPQTSxM) + somme(x=V,C,1..4 : RPQTSREMPxM);
regle 70111  :
application : iliad , batch  ;
REV1 = GLN1;
REV2 = GLN2;   
REV3 = GLN3;
REV4 = 4BAQTOTNET;
REVF = somme(i=V,C,1..4: PENFi);
REVALIM = somme (i=V,C,1..4: PENALIMi);
REVTS = somme (i=V,C,1..4:TSNN2i);
REVTSREMP = somme (i=V,C,1..4:TSNN2REMPi);
REVPRR = somme (i=V,C,1..4:PRR2i);
REVRVO = T2RV;
REVRCM = 2RCM + 3RCM + 4RCM + 5RCM + 6RCM + 7RCM;
REVRF = 2REVF+3REVF;
REVQTOT = somme(i=1..4 : REVi) + REVALIM + REVF+REVTS+REVPRR+REVRVO+REVRCM+REVRF;
regle 70112  :
application : iliad , batch  ;
GL1 = positif(REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * REV1 / TOTALQUO) +
     (1 - positif(REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * TONEQUO;
GL2 = positif(REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * REV2 / TOTALQUO) +
     (1 - positif(REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GL1);
GL3 = positif(REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * REV3 / TOTALQUO) +
     (1 - positif(REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO - GL1 - GL2);
GL4 = positif(REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * REV4 / TOTALQUO) +
     (1 - positif(REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO - GL1 - GL2 - GL3);
GLTOT = somme(i=1..4:GLi);
GLFV = positif(PENFC+PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENFV / TOTALQUO) +
      (1 - positif(PENFC+PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT);
GLFC = positif(PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENFC / TOTALQUO) +
      (1 - positif(PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFV);
GLF1 = positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENF1 / TOTALQUO) +
      (1 - positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFV-GLFC);
GLF2 = positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENF2 / TOTALQUO) +
      (1 - positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFV-GLFC-GLF1);
GLF3 = positif(PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENF3 / TOTALQUO) +
      (1 - positif(PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFV-GLFC-GLF1-GLF2);
GLF4 = positif(REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENF4 / TOTALQUO) +
      (1 - positif(REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFV-GLFC-GLF1-GLF2-GLF3);
GLFTOT = somme(i=V,C,1..4:GLFi);
GLPALIMV = positif(PENALIMC+PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIMV / TOTALQUO) +
      (1 - positif(PENALIMC+PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT);
GLPALIMC = positif(PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIMC / TOTALQUO) +
      (1 - positif(PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMV);
GLPALIM1 = positif(PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIM1 / TOTALQUO) +
      (1 - positif(PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMV-GLPALIMC);
GLPALIM2 = positif(PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIM2 / TOTALQUO) +
      (1 - positif(PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMV-GLPALIMC-GLPALIM1);
GLPALIM3 = positif(PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIM3 / TOTALQUO) +
      (1 - positif(PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMV-GLPALIMC-GLPALIM1-GLPALIM2);
GLPALIM4 = positif(REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PENALIM4 / TOTALQUO) +
      (1 - positif(REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMV-GLPALIMC-GLPALIM1-GLPALIM2-GLPALIM3);
GLPALIMTOT = somme(i=V,C,1..4:GLPALIMi);
GLTSV = positif(TSNN2TSC+TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TSV / TOTALQUO) +
      (1 - positif(TSNN2TSC+TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT);
GLTSC = positif(TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TSC / TOTALQUO) +
      (1 - positif(TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSV);
GLTS1 = positif(TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TS1 / TOTALQUO) +
      (1 - positif(TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSV-GLTSC);
GLTS2 = positif(TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TS2 / TOTALQUO) +
      (1 - positif(TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSV-GLTSC-GLTS1);
GLTS3 = positif(TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TS3 / TOTALQUO) +
      (1 - positif(TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSV-GLTSC-GLTS1-GLTS2);
GLTS4 = positif(REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2TS4 / TOTALQUO) +
      (1 - positif(REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSV-GLTSC-GLTS1-GLTS2-GLTS3);
GLTSTOT = somme(i=V,C,1..4:GLTSi);
GLTSREMPV = positif(TSNN2REMPC+TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMPV / TOTALQUO) +
      (1 - positif(TSNN2REMPC+TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLTSTOT-GLPALIMTOT);
GLTSREMPC = positif(TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMPC / TOTALQUO) +
      (1 - positif(TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPV);
GLTSREMP1 = positif(TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMP1 / TOTALQUO) +
      (1 - positif(TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPV-GLTSREMPC);
GLTSREMP2 = positif(TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMP2 / TOTALQUO) +
      (1 - positif(TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPV-GLTSREMPC-GLTSREMP1);
GLTSREMP3 = positif(TSNN2REMP4+TSNN2REMPC+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMP3 / TOTALQUO) +
      (1 - positif(TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPV-GLTSREMPC-GLTSREMP1-GLTSREMP2);
GLTSREMP4 = positif(REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUO * TSNN2REMP4 / TOTALQUO) +
      (1 - positif(REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPV-GLTSREMPC-GLTSREMP1-GLTSREMP2-GLTSREMP3);
GLTSREMPTOT = somme(i=V,C,1..4:GLTSREMPi);
GLPRRV = positif(PRR2C+PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR2V / TOTALQUO) +
      (1 - positif(PRR2C+PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT);
GLPRRC = positif(PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR2C / TOTALQUO) +
      (1 - positif(PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRV);
GLPRR1 = positif(PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR21 / TOTALQUO) +
      (1 - positif(PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRV-GLPRRC);
GLPRR2 = positif(PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR22 / TOTALQUO) +
      (1 - positif(PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRV-GLPRRC-GLPRR1);
GLPRR3 = positif(PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR23 / TOTALQUO) +
      (1 - positif(PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRV-GLPRRC-GLPRR1-GLPRR2);
GLPRR4 = positif(REVRVO+REVRCM+REVRF)*arr(TONEQUO * PRR24 / TOTALQUO) +
      (1 - positif(REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRV-GLPRRC-GLPRR1-GLPRR2-GLPRR3);
GLPRRTOT = somme(i=V,C,1..4:GLPRRi);
GLRVO = positif(2RV2 + 2RV3 + 2RV4 +REVRCM+REVRF)*arr(TONEQUO * 2RV1 / TOTALQUO) +
      (1 - positif(2RV2 + 2RV3 + 2RV4+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT);
GLRVO5 = positif(2RV3 + 2RV4+REVRCM+REVRF)*arr(TONEQUO * 2RV2 / TOTALQUO) +
      (1 - positif(2RV3 + 2RV4+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVO);
GLRVO6 = positif(2RV4+REVRCM+REVRF)*arr(TONEQUO * 2RV3 / TOTALQUO) +
      (1 - positif(2RV4+REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLPRRTOT-GLTSREMPTOT-GLRVO-GLRVO5);
GLRVO7 = positif(REVRCM+REVRF)*arr(TONEQUO * 2RV4 / TOTALQUO) +
      (1 - positif(REVRCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVO-GLRVO5-GLRVO6);
GLRVOTOT = GLRVO + GLRVO5 + GLRVO6 + GLRVO7;
GLRCMDC  = positif(3RCM+4RCM+5RCM+6RCM+7RCM+REVRF)*arr(TONEQUO * 2RCM / TOTALQUO) +
      (1 - positif(3RCM+4RCM+5RCM+6RCM+7RCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT);
GLRCMFU  = positif(4RCM+5RCM+6RCM+7RCM+REVRF)*arr(TONEQUO * 3RCM / TOTALQUO) +
      (1 - positif(4RCM+5RCM+6RCM+7RCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT - GLRCMDC);
GLRCMCH  = positif(5RCM+6RCM+7RCM+REVRF)*arr(TONEQUO * 4RCM / TOTALQUO) +
      (1 - positif(5RCM+6RCM+7RCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT - GLRCMDC - GLRCMFU);
GLRCMTS  = positif(6RCM+7RCM+REVRF)*arr(TONEQUO * 5RCM / TOTALQUO) +
      (1 - positif(6RCM+7RCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT - GLRCMDC - GLRCMFU - GLRCMCH);
GLRCMGO = positif(7RCM+REVRF)*arr(TONEQUO * 6RCM / TOTALQUO) +
      (1 - positif(7RCM+REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT - GLRCMDC - GLRCMFU - GLRCMCH - GLRCMTS);
GLRCMTR  = positif(REVRF)*arr(TONEQUO * 7RCM / TOTALQUO) +
      (1 - positif(REVRF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT - GLRCMDC - GLRCMFU - GLRCMCH - GLRCMGO - GLRCMTS);
GLRCMTOT = GLRCMDC + GLRCMFU + GLRCMCH + GLRCMGO + GLRCMTR + GLRCMTS;
GLRF1  = positif(3REVF)*arr(TONEQUO * 2REVF / TOTALQUO) +
      (1 - positif(3REVF)) * (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT-GLRCMTOT);
GLRF2  = (TONEQUO-GLTOT-GLFTOT-GLPALIMTOT-GLTSTOT-GLTSREMPTOT-GLPRRTOT-GLRVOTOT-GLRCMTOT-GLRF1);
GLRFTOT = GLRF1 + GLRF2;
regle 701125  :
application : iliad , batch  ;
GL1M = positif(REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * REV1 / TOTALQUO) +
     (1 - positif(REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * TONEQUOM;
GL2M = positif(REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * REV2 / TOTALQUO) +
     (1 - positif(REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GL1M);
GL3M = positif(REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * REV3 / TOTALQUO) +
     (1 - positif(REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM - GL1M - GL2M);
GL4M = positif(REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * REV4 / TOTALQUO) +
     (1 - positif(REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM - GL1M - GL2M - GL3M);
GLTOTM = somme(i=1..4:GLiM);
GLFVM = positif(PENFC+PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENFV / TOTALQUO) +
      (1 - positif(PENFC+PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM);
GLFCM = positif(PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENFC / TOTALQUO) +
      (1 - positif(PENF1+PENF2+PENF3+PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFVM);
GLF1M = positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENF1 / TOTALQUO) +
      (1 - positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFVM-GLFCM);
GLF2M = positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENF2 / TOTALQUO) +
      (1 - positif(PENF2+PENF3+PENF4+REV1+REV2+REV3+REV4+REVF+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFVM-GLFCM-GLF1M);
GLF3M = positif(PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENF3 / TOTALQUO) +
      (1 - positif(PENF4+REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFVM-GLFCM-GLF1M-GLF2M);
GLF4M = positif(REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENF4 / TOTALQUO) +
      (1 - positif(REVALIM+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOT-GLFVM-GLFCM-GLF1M-GLF2M-GLF3M);
GLFTOTM = somme(i=V,C,1..4:GLFiM);
GLPALIMVM = positif(PENALIMC+PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIMV / TOTALQUO) +
      (1 - positif(PENALIMC+PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM);
GLPALIMCM = positif(PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIMC / TOTALQUO) +
      (1 - positif(PENALIM1+PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMVM);
GLPALIM1M = positif(PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIM1 / TOTALQUO) +
      (1 - positif(PENALIM2+PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMVM-GLPALIMCM);
GLPALIM2M = positif(PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIM2 / TOTALQUO) +
      (1 - positif(PENALIM3+PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMVM-GLPALIMCM-GLPALIM1M);
GLPALIM3M = positif(PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIM3 / TOTALQUO) +
      (1 - positif(PENALIM4+REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMVM-GLPALIMCM-GLPALIM1M-GLPALIM2M);
GLPALIM4M = positif(REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PENALIM4 / TOTALQUO) +
      (1 - positif(REVTS+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMVM-GLPALIMCM-GLPALIM1M-GLPALIM2M-GLPALIM3M);
GLPALIMTOTM = somme(i=V,C,1..4:GLPALIMiM);
GLTSVM = positif(TSNN2TSC+TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TSV / TOTALQUO) +
      (1 - positif(TSNN2TSC+TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM);
GLTSCM = positif(TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TSC / TOTALQUO) +
      (1 - positif(TSNN2TS1+TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSVM);
GLTS1M = positif(TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TS1 / TOTALQUO) +
      (1 - positif(TSNN2TS2+TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSVM-GLTSCM);
GLTS2M = positif(TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TS2 / TOTALQUO) +
      (1 - positif(TSNN2TS3+TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSVM-GLTSCM-GLTS1M);
GLTS3M = positif(TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TS3 / TOTALQUO) +
      (1 - positif(TSNN2TS4+REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSVM-GLTSCM-GLTS1M-GLTS2M);
GLTS4M = positif(REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2TS4 / TOTALQUO) +
      (1 - positif(REVTSREMP+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSVM-GLTSCM-GLTS1M-GLTS2M-GLTS3M);
GLTSTOTM = somme(i=V,C,1..4:GLTSiM);
GLTSREMPVM = positif(TSNN2REMPC+TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2REMPV / TOTALQUO) +
      (1 - positif(TSNN2REMPC+TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM);
GLTSREMPCM = positif(TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2REMPC / TOTALQUO) +
      (1 - positif(TSNN2REMP1+TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPVM);
GLTSREMP1M = positif(TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2REMP1 / TOTALQUO) +
      (1 - positif(TSNN2REMP2+TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPVM-GLTSREMPCM);
GLTSREMP2M = positif(TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2REMP2 / TOTALQUO) +
      (1 - positif(TSNN2REMP3+TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPVM-GLTSREMPCM-GLTSREMP1M);
GLTSREMP3M = positif(TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN2REMP3 / TOTALQUO) +
      (1 - positif(TSNN2REMP4+REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPVM-GLTSREMPCM-GLTSREMP1M-GLTSREMP2M);
GLTSREMP4M = positif(REVPRR+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * TSNN24 / TOTALQUO) +
      (1 - positif(REVPRR+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPVM-GLTSREMPCM-GLTSREMP1M-GLTSREMP2M-GLTSREMP3M);
GLTSREMPTOTM = somme(i=V,C,1..4:GLTSREMPiM);
GLPRRVM = positif(PRR2C+PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR2V / TOTALQUO) +
      (1 - positif(PRR2C+PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM);
GLPRRCM = positif(PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR2C / TOTALQUO) +
      (1 - positif(PRR21+PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRVM);
GLPRR1M = positif(PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR21 / TOTALQUO) +
      (1 - positif(PRR22+PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRVM-GLPRRCM);
GLPRR2M = positif(PRR23+PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR22 / TOTALQUO) +
      (1 - positif(PRR23+PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUO-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRVM-GLPRRCM-GLPRR1M);
GLPRR3M = positif(PRR24+REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR23 / TOTALQUO) +
      (1 - positif(PRR24+REVRVO+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRVM-GLPRRCM-GLPRR1M-GLPRR2M);
GLPRR4M = positif(REVRVO+REVRCM+REVRF)*arr(TONEQUOM * PRR24 / TOTALQUO) +
      (1 - positif(REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRVM-GLPRRCM-GLPRR1M-GLPRR2M-GLPRR3M);
GLPRRTOTM = somme(i=V,C,1..4:GLPRRiM);
GLRVOM = positif(2RV2 + 2RV3 + 2RV4 +REVRCM+REVRF)*arr(TONEQUOM * 2RV1 / TOTALQUO) +
      (1 - positif(2RV2 + 2RV3 + 2RV4+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM);
GLRVO5M = positif(2RV3 + 2RV4+REVRCM+REVRF)*arr(TONEQUOM * 2RV2 / TOTALQUO) +
      (1 - positif(2RV3 + 2RV4+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOM);
GLRVO6M = positif(2RV4+REVRCM+REVRF)*arr(TONEQUOM * 2RV3 / TOTALQUO) +
      (1 - positif(2RV4+REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOM-GLRVO5M);
GLRVO7M = positif(REVRCM+REVRF)*arr(TONEQUOM * 2RV4 / TOTALQUO) +
      (1 - positif(REVRCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOM-GLRVO5M-GLRVO6M);
GLRVOTOTM = GLRVOM + GLRVO5M + GLRVO6M + GLRVO7M;
GLRCMDCM = positif(3RCM+4RCM+5RCM+6RCM+7RCM+REVRF)*arr(TONEQUOM * 2RCM / TOTALQUO) +
      (1 - positif(3RCM+4RCM+5RCM+6RCM+7RCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM);
GLRCMFUM = positif(4RCM+5RCM+6RCM+7RCM+REVRF)*arr(TONEQUOM * 3RCM / TOTALQUO) +
      (1 - positif(4RCM+5RCM+6RCM+7RCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM - GLRCMDCM);
GLRCMCHM = positif(5RCM+6RCM+7RCM+REVRF)*arr(TONEQUOM * 4RCM / TOTALQUO) +
      (1 - positif(5RCM+6RCM+7RCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM - GLRCMDCM - GLRCMFUM);
GLRCMTSM = positif(6RCM+7RCM+REVRF)*arr(TONEQUOM * 5RCM / TOTALQUO) +
      (1 - positif(6RCM+7RCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM - GLRCMDCM - GLRCMFUM - GLRCMCHM);
GLRCMGOM = positif(7RCM+REVRF)*arr(TONEQUOM * 6RCM / TOTALQUO) +
      (1 - positif(7RCM+REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM - GLRCMDCM - GLRCMFUM - GLRCMCHM - GLRCMTSM);
GLRCMTRM = positif(REVRF)*arr(TONEQUOM * 7RCM / TOTALQUO) +
      (1 - positif(REVRF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM  - GLRCMDCM - GLRCMFUM - GLRCMCHM - GLRCMGOM - GLRCMTSM);
GLRCMTOTM = GLRCMDCM + GLRCMFUM + GLRCMCHM + GLRCMGOM + GLRCMTRM + GLRCMTSM;
GLRF1M  = positif(3REVF)*arr(TONEQUOM * 2REVF / TOTALQUO) +
      (1 - positif(3REVF)) * (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM-GLRCMTOTM);
GLRF2M  = (TONEQUOM-GLTOTM-GLFTOTM-GLPALIMTOTM-GLTSTOTM-GLTSREMPTOTM-GLPRRTOTM-GLRVOTOTM-GLRCMTOTM-GLRF1M);
GLRFTOTM = GLRF1M + GLRF2M;
regle 7012:
application : iliad , batch  ;
RPQ1 = inf(GL1 / DIVGL1)+0;
RPQ2 = inf(GL2 / DIVGL2)+0;
RPQ3 = inf(GL3 / DIVGL3)+0;
RPQ4 = inf(GL4 / DIVGL4)+0;
pour x=V,C,1..4:
RPQFx = inf(GLFx/COTFx);
pour x=V,C:
RPQPALIMx = inf(GLPALIMx/PENSALNBx);
pour x=1..4:
RPQPALIMx = inf(GLPALIMx/PENSALNBPx);
RPQRF1 = inf(GLRF1/FONCINB);
RPQRF2 = inf(GLRF2/REAMORNB);
RPQRCMDC = inf(GLRCMDC/REVACTNB);
RPQRCMFU = inf(GLRCMFU/REVPEANB);
RPQRCMCH = inf(GLRCMCH/PROVIENB);
RPQRCMTS = inf(GLRCMTS/DISQUONB);
RPQRCMGO = inf(GLRCMGO/RESTUCNB);
RPQRCMTR = inf(GLRCMTR/INTERENB);
pour i=V,C:
RPQPRRi = inf(GLPRRi/CARPENBAi);
pour i=1..4:
RPQPRRi = inf(GLPRRi/CARPENBAPi);
RPQRVO = inf(GLRVO/RENTAXNB);
RPQRVO5 = inf(GLRVO5/RENTAXNB5);
RPQRVO6 = inf(GLRVO6/RENTAXNB6);
RPQRVO7 = inf(GLRVO7/RENTAXNB7);
pour i=V,C:
RPQTSi = inf(GLTSi/CARTSNBAi);
pour i=1..4:
RPQTSi = inf(GLTSi/CARTSNBAPi);
pour i=V,C :
RPQTSREMPi = inf(GLTSREMPi/REMPLANBi);
pour i=1..4 :
RPQTSREMPi = inf(GLTSREMPi/REMPLANBPi);
regle 70125:
application : iliad , batch  ;
pour i=1..4:
RPQiM = inf(GLiM / DIVGLi);
pour i=V,C,1..4:
RPQFiM = inf(GLFiM/COTFi);
pour i=V,C:
RPQPALIMiM = inf(GLPALIMiM/CARPENBAi);
pour i=1..4:
RPQPALIMiM = inf(GLPALIMiM/CARPENBAPi);
RPQRF1M = inf(GLRF1M/FONCINB);
RPQRF2M = inf(GLRF2M/REAMORNB);
RPQRCMDCM = inf(GLRCMDCM/REVACTNB);
RPQRCMFUM = inf(GLRCMFUM/REVPEANB);
RPQRCMCHM = inf(GLRCMCHM/PROVIENB);
RPQRCMTSM= inf(GLRCMTSM/DISQUONB);
RPQRCMGOM = inf(GLRCMGOM/RESTUCNB);
RPQRCMTRM = inf(GLRCMTRM/INTERENB);
pour i=V,C:
RPQPRRiM = inf(GLPRRiM/PENSALNBi);
pour i=1..4:
RPQPRRiM = inf(GLPRRiM/PENSALNBPi);
RPQRVOM = inf(GLRVOM/RENTAXNB);
RPQRVO5M = inf(GLRVO5M/RENTAXNB5);
RPQRVO6M = inf(GLRVO6M/RENTAXNB6);
RPQRVO7M = inf(GLRVO7M/RENTAXNB7);
pour i=V,C:
RPQTSiM = inf(GLTSiM/CARTSNBAi);
pour i=1..4:
RPQTSiM = inf(GLTSiM/CARTSNBAPi);
pour i=V,C :
RPQTSREMPiM = inf(GLTSREMPiM/REMPLANBi);
pour i=1..4 :
RPQTSREMPiM = inf(GLTSREMPiM/REMPLANBPi);

regle 701211:
application : iliad , batch  ;
pour x = 1..3 :
GLNx = GLNxV + GLNxC;
regle 7013:
application : bareme , iliad , batch  ;
RI2 = RI1 + DPAE;
RI3 = max( RI1 , 0 );
regle 70130:
application : iliad , batch  ;
LIMDPAE = LIM_PENSALENF ;
regle 70131:
application : iliad , batch  ;
DPAE = somme (a=1..4 : min( CHENFa, LIMDPAE)) * ( 1 - V_CNR ) ;
regle 702:
application : bareme , iliad , batch  ;
RI1 =   max( RNG - (( 1 - min ( 1 ,IPVLOC )) * ABTPA ) - ABTMA, 0 );
regle 703:
application : bareme , iliad , batch  ;
RNG = (     null(V_REGCO - 4)
          * null(V_CNR   - 1)
          * null(V_CNR2  - 1)
          * null(V_CR2   - 1)
          * IPVLOC
      )
     +
     (1 -   null(V_REGCO - 4)
          * null(V_CNR   - 1)
          * null(V_CNR2  - 1)
          * null(V_CR2   - 1)
      )
      * RBL ; 
regle 7033 :
application : bareme , iliad , batch  ;
REVQUO = max(0, TOTALQUO - SDD - SDC - SDV - SDM);
TONEQUO = max(0, TOTALQUO 
               - (SDD + SDC + SDV + SDM) * (1- positif(IPTEFP + IPTEFN + TEFFREVTOT*INDTEFF))
                 - IPTEFN);
TONEQUOM = max(0, TOTALQUO - DMOND) ;
regle 7031:
application : iliad , batch  ;
NAB =   min( max( LIM_ABTRNGDBL + 1  - (RNG+ TOTALQUO- SDD- SDC), 0 ), 1 )
      + min( max( LIM_ABTRNGSIMP + 1 - (RNG+ TOTALQUO- SDD- SDC), 0 ), 1 );
ABSPRNG = RNG + TOTALQUO - SDD - SDC;
ABTPA = NDA * NAB * ABAT_UNVIEUX * (1-V_CNR) ;
regle 703110 :
application : bareme , iliad , batch  ;
NDA =   min( max( AGV + 1 - LIM_AGE_ABVIEUX, V_0AP ), 1 )
      + min( max( AGC*BOOL_0AM + 1 - LIM_AGE_ABVIEUX, V_0AF*BOOL_0AM ), 1 )  ;
regle 70311 :
application : bareme , iliad , batch  ;
AGV = (V_ANREV - V_0DA) * min( 1 , V_0DA) ;
AGC = (V_ANREV - V_0DB) * min( 1 , V_0DB) ;
regle 7032:
application : iliad , batch  ;
ABTMA = V_0DN * ABAT_ENF_MARIES + arr(V_0DP * (ABAT_ENF_MARIES)/2);
regle 704:
application : bareme , iliad , batch  ;
RBG2 = RBG - min(RBG , DDCSG);
RBL =  ( RBG2 - min( RBG2 , ( DPA + DFA + DEDIV + APERPV + APERPC + APERPP + NUREPAR )) * ( 1 - V_CNR ) 
              - min( RBG2 , V_8ZT) * V_CR2 
       ) * (1 - positif(RE168+TAX1649));
regle 7041 :
application : bareme , iliad , batch  ;
SDD = max(0, DAR - RG);
regle 704100 :
application : bareme  , iliad , batch  ;
SDC1 = max(0, DDCSG + DPA + DFA + DEDIV - APERPV - APERPC - APERPP - max(0,RBG)) 
          * (1 - V_CNR)
          + max (0, V_8ZT - max(0,RBG)) * V_CR2;
regle 70411 :
application : bareme , iliad , batch  ;
SDC = max(0, DDCSG + DPA + DFA + DEDIV + APERPV + APERPC + APERPP + NUREPAR - max(0,RBG)) 
         * (1 - V_CNR)
         + max(0, V_8ZT - max(0,RBG)) *  V_CR2;
regle 70412 :
application : bareme , iliad , batch  ;
SDV = max(0, ABTPA - RNG);
SDM = max(0, ABTMA - max(0,RNG - ABTPA) );
regle 70432:
application : iliad , batch ;

SOFIRNG = RBL + TOTALQUO - SDD - SDC1;

regle 705:
application : bareme , iliad , batch  ;
RBG = (1 - positif(RG  + R1649 +PREREV- DAR)) * min( 0 , RG  + R1649 +PREREV- DAR + TOTALQUO )
    + positif(RG  + R1649+PREREV - DAR) * (RG  + R1649+PREREV - DAR);
regle 7051:
application : iliad , batch  ;
TOTPA =arr(PAAV*MAJREV) + PAAP;
DPA = (somme(i=1..4:min(NCHENFi,LIMDPAE)+min(arr(CHENFi*MAJREV),LIMDPAE))
                  + TOTPA) * (1 - V_CNR)
                             * (1 - positif(RE168+TAX1649)) ;
regle 7053:
application : iliad , batch  ;
RPREC =  positif(CHRFAC) * max(1,CHNFAC)
         +
	 null(CHRFAC) * max(0,CHNFAC)
         ;
DFA = min( CHRFAC, RPREC * LIM_FRACC ) * (1 - V_CNR)
                             * (1 - positif(RE168+TAX1649)) ;
regle 706 :
application : bareme , iliad , batch  ;
RG = (1 - positif(IPVLOC)) * (
        ( SHBA +  max( BANOR, 0 ) + REB +
        min(BANOR,0) *
        positif(SEUIL_IMPDEFBA + 1 - SHBA - (REVTP-BA1)
        - REV1 - REV2 - REV3 - REV4 - REVRF) 
       ) ) 
     +
     positif( IPVLOC ) * IPVLOC;
regle 70611 :
application : bareme , iliad , batch  ;
TOTALQUO = (1-positif(IPVLOC)) * REVQTOT;
regle 7061:
application : iliad , batch  ;
DAR = (DEFAA5 + DEFAA4 + DEFAA3 + DEFAA2 + DEFAA1 + DEFAA0) * (1 - positif(IPVLOC));
regle 707:
application : iliad , batch  ;
SHBA = ESFP + TSPR + RCM + BIN + BNN + PLOCNETF + NPLOCNETF
       + (RRFI + 0) * ( 1- V_INDTEO) + (RRFTEO + 0) * (V_INDTEO);
regle 7070:
application :  bareme   ;
SHBA = arr(V_9ZZ);
regle 7071:
application : iliad , batch  ;
REB =  REPSOF;
