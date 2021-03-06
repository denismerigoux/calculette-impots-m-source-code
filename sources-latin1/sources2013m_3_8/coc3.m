#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2017]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2014 
#au titre des revenus per�us en 2013. La pr�sente version a permis la 
#g�n�ration du moteur de calcul des cha�nes de taxation des r�les d'imp�t 
#sur le revenu de ce mill�sime.
#
#Ce logiciel est r�gi par la licence CeCILL 2.1 soumise au droit fran�ais 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffus�e par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez acc�der � cet en-t�te signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accept� les termes.
#
#**************************************************************************************************************************
verif 3003:
application : iliad , batch ;
si
   V_0AM + 0 = 1  
   et  
   V_0AE + V_0AG + V_0AN + V_0AW + V_0AL + 0 > 0 
   
alors erreur A01001 ;
verif 3513:
application : iliad , batch ;
si
   V_0AO + 0 = 1  
   et  
   V_0AE + V_0AG + V_0AL + V_0AN + V_0AW + V_0AU + 0 > 0  
   
alors erreur A01002 ;
verif 3004:
application : iliad , batch ;
si
   V_0AV + 0 = 1  
   et 
   BOOL_0AZ != 1 
   et 
   V_0AF + V_0AS + V_0AU + 0 > 0
   
alors erreur A01003 ;
verif 3005:
application : iliad , batch ;
si
   V_0AC + 0 = 1  
   et  
   V_0AF + V_0AS + V_0AU + 0 > 0  
  
alors erreur A01004 ;
verif 3006:
application : iliad , batch ;
si
   V_0AD + 0 = 1  
   et  
   V_0AF + V_0AS + V_0AU + 0 > 0  
   
alors erreur A01005 ;
verif 3007:
application : iliad , batch ;
si
   V_0AM + 0 = 1 
   et 
   V_0BT + 0 = 1
   
alors erreur A01009 ;
verif 3009:
application : iliad , batch ;
si 
   V_0AP + V_0AF + V_0AS+ V_0AE + V_0AW + V_0AL + V_0AN + V_0AG + V_0BT + 0 > 0
   et
   positif(V_0AM + V_0AO + V_0AC + V_0AD + V_0AV + 0) != 1
   
alors erreur A01011 ;
verif 3010:
application : iliad , batch ;
si  
   V_0AC = 1 
   et 
   V_0AG = 1
   
alors erreur A01006 ;
verif 3011:
application : iliad , batch ;
si  
   V_0AD = 1 
   et 
   V_0AG = 1
   
alors erreur A01007 ;
verif 3012:
application : iliad , batch ;
si  
   V_0AV = 1 
   et 
   V_INDG = 1 
   et 
   V_0AG = 1 
   ou
   (present(V_0AZ) = 1 et V_0AV = 1 et BOOL_0AZ != 1 et V_INDG = 1 et V_0AG = 1)
   
alors erreur A01008 ;
verif 3514:
application : iliad , batch ;
si
   V_0AO + 0 = 1 
   et 
   V_0BT+0 = 1
   
alors erreur A01010 ;
verif 3013:
application : iliad , batch ;
si  
   V_IND_TRAIT + 0 = 4
   et
   (V_0DA < (V_ANREV - 123) ou V_0DA > V_ANREV ou V_0DB < (V_ANREV - 123) ou V_0DB > V_ANREV)

alors erreur A013 ;
verif  3014:
application : iliad , batch ;
si
   V_IND_TRAIT = 5
   et
   (
      ( positif(V_0DB) = 1 et ( V_0DB < (V_ANREV - 123) ou V_0DB > V_ANREV ) )
    ou
      ( V_0DA < (V_ANREV - 123) ou V_0DA > V_ANREV ) 
    )
   
alors erreur A013 ;
verif 171:
application : iliad , batch;

si 
   APPLI_COLBERT + APPLI_OCEANS = 0 
   et 
   V_ZDC = 1 
   et 
   somme(i=X,Y,Z: positif(V_0Ai)) > 1
   
alors erreur A01701 ;
verif 172:
application : iliad , batch ;

si 
   APPLI_COLBERT + APPLI_OCEANS = 0 
   et 
   V_ZDC = 4
   et 
   (  
    positif(V_0AZ + 0) = 0 
    ou 
    V_0AM + V_0AO + (V_0AC + V_0AD + V_0AV) * V_0AB + 0 = 0
   )
   
alors erreur A01702 ;
verif 173:
application : iliad , batch ;
si 
   APPLI_COLBERT + APPLI_OCEANS = 0 
   et 
   V_ZDC = 1
   et
   positif(V_0AX) = 1 
   et 
   V_0AM + V_0AO + 0 = 0

alors erreur A01703 ;
verif 174:
application : iliad , batch ;
si 
   APPLI_COLBERT + APPLI_OCEANS = 0 
   et 
   V_ZDC = 1
   et
   positif(V_0AY) = 1 
   et 
   V_0AD + 0 = 0

alors erreur A01704 ;
verif 175:
application : batch, iliad;

si 
   APPLI_COLBERT + APPLI_OCEANS = 0 
   et 
   V_ZDC = 1 
   et 
   positif(V_0AZ) = 1 
   et 
   V_0AV + V_0AM + 0 = 0
  
alors erreur A01705 ;
verif 18:
application : batch ;

si 
   APPLI_COLBERT = 0 
   et 
   null(10 - V_NOTRAIT) = 1
   et
   V_ZDC + 0 = 0 
   et 
   positif(V_0AZ) = 1 
   et 
   V_0AV + V_0AM + V_0AO + 0 = 0
   
alors erreur A018 ;
verif 3041:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   V_0AC = 1 
   et 
   V_0AZ + 0 > 0
   
alors erreur AS0101 ;
verif 3042:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   BOOL_0AM = 1
   et
   V_0AX + 0 > 0
   et
   V_0AB + 0 > 0
   
alors erreur AS0102 ;
verif 3043:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   V_0AC + V_0AD + V_0AV + 0 = 1
   et
   V_0AX + 0 > 0
   et
   positif(V_0AB + 0) = 0
   
alors erreur AS0103 ;
verif 3044:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   BOOL_0AM = 1 
   et 
   V_0AY + 0 > 0  
   
alors erreur AS0104 ;
verif 3045:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   V_0AM = 1 
   et 
   V_0AY + 0 > 0 
   et 
   V_0AZ + 0 > 0 
   
alors erreur AS0105 ;
verif 3046:
application : batch , iliad ;
si
   APPLI_COLBERT + APPLI_ILIAD = 1 
   et 
   V_ZDC + 0 = 0
   et
   V_0AD = 1 
   et 
   V_0AZ + 0 > 0
   
alors erreur AS0106 ;
verif 3047:
application : batch ;
si
   APPLI_COLBERT = 1 
   et 
   positif(V_IND_TRAIT + 0) = 1 
   et
   V_NOTRAIT + 0 < 14
   et
   present(V_ANTIR) = 0
   et
   positif(V_0DA + 0) = 0
  
alors erreur AS11 ;
verif 3100:
application : iliad , batch ;
si
   (
     (  V_0CF + 0 < V_0CG )
   )
alors erreur A01201;
verif 3101:
application : iliad , batch ;
si
   (
     (  V_0CI + 0 > V_0CH +0 ) 
   )
alors erreur A01202;
verif 3110:
application : iliad ;
si (APPLI_OCEANS+0 = 0) et 
        present(V_CALCULIR) = 0 
        et
    (V_0CF+0 != somme (i = 0..7: positif(V_0Fi+0)))
alors erreur IM1101;
verif 3111:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CG != somme (i = 0, 1, 2, 3: positif(V_0Gi+0))
   )
alors erreur IM1102;
verif 3112:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
     present(V_CALCULIR) = 0 
	et 
     V_0CR != somme (i = 0, 1, 2, 3: positif(V_0Ri+0))
   )
alors erreur IM1105;
verif 3113:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DJ != somme (i = 0, 1, 2, 3: positif(V_0Ji+0))
   )
alors erreur IM1106;
verif 3114:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DN != somme (i = 0, 1, 2, 3: positif(V_0Ni+0))
   )
alors erreur IM1107;
verif 3118:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CH != somme (i = 0,1,2,3,4,5: positif(V_0Hi+0))
   )
alors erreur IM1103;
verif 3116:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CI != somme (i = 0, 1, 2, 3: positif(V_0Ii+0))
   )
alors erreur IM1104;
verif 3117:
application : iliad ;
si (APPLI_OCEANS=0) et 
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DP !=  positif(V_0P0+0)
   )
alors erreur IM1108;
verif 3200:
application : bareme ;
si (
   ( V_9VV < 2 et (V_0AM + V_0AO + 0 = 1) )
   )
alors erreur A063;
verif 3201:
application : bareme ;
si (
   ( V_9VV < 1.25 et ( (V_0AC = 1 ou V_0AD = 1) et V_9XX = 1 ))
   )
alors erreur A064;
verif 3202:
application : bareme ;
si (
   ( V_9VV < 2.25 et ( (BOOL_0AM = 1 ou V_0AV = 1) et V_9XX = 1 ))
   )
alors erreur A064;
verif 32021:
application : bareme ;
si (
    V_9VV = 1.25 et  V_0BT=1 et V_9XX=1 
   )
alors erreur A064;
verif 3203:
application : bareme ;
si (
    V_9VV < 2 et  (V_0AV +V_0AZ = 2)
   )
alors erreur A066;
verif 3210:
application : iliad , batch;
si (APPLI_OCEANS = 0) et (
    (V_0AM + V_0AO + 0 = 1) et V_0AS = 1 et V_0AP+0 = 0 et V_0AF+0 = 0
	  et 
   V_ANREV - V_0DA < 75 et V_ANREV - V_0DB < 75
   )
alors erreur I011;
verif 3221:
application : batch , iliad ;
si (APPLI_OCEANS=0) et (
    (V_0AM + V_0AO + 0 = 0 )
	  et 
    V_0AZ + 0 = 0
          et
    V_0AP + 0 = 0
          et
    (V_0AE + 0 = 0 ou (V_0AE + 0 = 1 et (V_0DJ + 0 > 0 ou V_0DN + 0 > 0)))
          et
    V_0AW = 1
	  et 
    V_ANREV - V_0DA < 75
   )
alors erreur I012;
verif 3216:
application : batch , iliad ;
si 
    V_IND_TRAIT > 0
    et
    V_REGCO != 2
    et
    V_REGCO != 4
    et
   (
    DEFRCM + 0 > V_BTDFRCM1 + PLAF_PRECONS * (1 - positif(V_BTDFRCM1))
    ou
    DEFRCM2 + 0 > V_BTDFRCM2 + PLAF_PRECONS * (1 - positif(V_BTDFRCM2))
    ou
    DEFRCM3 + 0 > V_BTDFRCM3 + PLAF_PRECONS * (1 - positif(V_BTDFRCM3))
    ou
    DEFRCM4 + 0 > V_BTDFRCM4 + PLAF_PRECONS * (1 - positif(V_BTDFRCM4))
    ou
    DEFRCM5 + 0 > V_BTDFRCM5 + PLAF_PRECONS * (1 - positif(V_BTDFRCM5))
    ou
    DEFRCM6 + 0 > V_BTDFRCM6 + PLAF_PRECONS * (1 - positif(V_BTDFRCM6)))

alors erreur I015 ;
verif 3217:
application : batch , iliad ;

si
    V_IND_TRAIT > 0
    et
    V_REGCO != 2
    et
    V_REGCO != 4
    et
    positif(PVSURSI + PVIMPOS + COD3WI + 0) = 1

alors erreur I016 ;
verif 3301:
application : iliad, batch ;
si (APPLI_OCEANS = 0) et 
  ( 
 	V_0AV  = 1     
	et
       (
       (
        positif(XETRANC) + positif(TSELUPPEC) + positif(EXOCETC) + positif(FRNC)
	+ positif(TSHALLOC) + positif(CODDBJ) + positif(CODEBJ) + positif(ALLOC) 
	+ positif(HEURESUPC)
        + positif(SALEXTC) + positif(COD1BD) + positif(COD1BE) + positif(PPEXTC) + positif(COD1BH)
	+ positif(PRBC) + somme(i=2..4:positif(iPRBC)) + positif(PEBFC) 
	+ positif(CARTSC) + positif(REMPLAC) + positif(CARPEC) + positif(PENSALC)
	+ somme (i=1..3: positif (GLDiC)) + somme (i=A: positif(BiFC) + somme(j=A: positif(Bi1jC)))
	+ somme (i=H,C: 
       			somme(j= A,N: somme(k=R,D: positif(BjikEC))) + 
       			somme(j=N: positif(BIiDjC)) + positif(BIiNOC)  
          )
	+ positif(BICREC) + positif(BI2AC) + positif(BICDEC)
        + positif(TSASSUC)
	+ positif(PPETPC) + positif(PPENHC)
	+ positif(GSALC) + positif(PCAPTAXC)

 + positif( FEXC ) + positif( BAFC ) + positif( BAFORESTC ) + positif( BAFPVC ) + positif( BAF1AC ) 
 + positif( BAEXC ) + positif( BACREC ) + positif( 4BACREC ) + positif( BA1AC ) 
 + positif(BACDEC)
 + positif( BAHEXC ) + positif( BAHREC ) + positif( 4BAHREC ) 
 + positif( BAHDEC ) + positif( BAPERPC ) + positif( BANOCGAC )
 + positif( AUTOBICVC ) + positif( AUTOBICPC ) + positif( MIBEXC ) + positif( MIBVENC ) 
 + positif( MIBPRESC ) + positif( MIBPVC ) + positif( MIB1AC ) + positif( MIBDEC ) 
 + positif( BICEXC ) + positif( BICNOC ) + positif( LOCPROCGAC )
 + positif( BI1AC ) + positif(BICDNC ) 
 + positif( LOCDEFPROCGAC )
 + positif( BIHEXC ) + positif( BIHNOC ) + positif( LOCPROC )
 + positif( BIHDNC ) + positif( BIPERPC ) 
 + positif( LOCDEFPROC )
 + positif( MIBMEUC ) + positif( MIBGITEC ) + positif( MIBNPEXC ) + positif( MIBNPVENC ) 
 + positif( MIBNPPRESC ) + positif( MIBNPPVC ) + positif( MIBNP1AC ) + positif( MIBNPDEC ) 
 + positif( BICNPEXC ) + positif( BICREC ) + positif( LOCNPCGAC )
 + positif( BI2AC ) + positif( LOCDEFNPCGAC) 
 + positif( BICNPHEXC ) + positif( BICHREC ) + positif( LOCNPC )
 + positif( BICHDEC)  
 + positif(LOCDEFNPC)
 + positif( AUTOBNCC ) + positif( BNCPROEXC ) + positif( BNCPROC ) 
 + positif( BNCPROPVC ) + positif( BNCPRO1AC ) + positif( BNCPRODEC ) 
 + positif( BNCEXC ) + positif( BNCREC ) + positif( BN1AC ) 
 + positif( BNCDEC ) 
 + positif( BNHEXC ) + positif( BNHREC ) + positif( BNHDEC ) 
 + positif ( BNCCRC ) + positif ( CESSASSC ) + positif( XHONOAAC ) + positif( XHONOC )
 + positif( BNCNPC ) + positif( BNCNPPVC ) + positif( BNCNP1AC ) + positif( BNCNPDEC ) 
 + positif( BNCNPREXAAC ) + positif( BNCAABC ) + positif( BNCNPREXC ) + positif( ANOVEP )
 + positif( INVENTC ) + positif( PVINCE ) + positif( BNCAADC) 
 + positif( DNOCEPC ) + positif( BNCCRFC )
 + positif( RCSC ) + positif( BANOCGAC ) + positif( PVSOCC ) + positif( PPEACC ) + positif( PPENJC ) 

 + positif( PERPC ) + positif( PERP_COTC ) + positif( RACCOTC ) + positif( PLAF_PERPC ) 
 + positif ( PERPPLAFCC ) + positif ( PERPPLAFNUC1 ) + positif ( PERPPLAFNUC2 ) + positif ( PERPPLAFNUC3 )
 + positif ( RDSYCJ )
 + positif( ELURASC ) 
     )
	> 0 
     )
   )
alors erreur I010 ;
verif 3416:
application : batch ;
si
   V_IND_TRAIT > 0
   et
   positif(V_0AB + 0) = 1
   et
   (positif(V_0AX + 0) = 0
    ou
    positif(V_0AM + V_0AO + 0) = 1)

alors erreur A004 ;
verif 3417:
application : batch ;
si
   V_IND_TRAIT > 0
   et
   positif(V_0AX + 0) = 1
   et
   positif(V_0AC + V_0AD + V_0AV + 0) = 1
   et 
   positif(V_0AB + 0) = 0

alors erreur A005 ;
verif 3500:
application : iliad ;
si 
    positif(FLAGDERNIE+0) = 1
    et
    positif(null(V_NOTRAIT - 23) + null(V_NOTRAIT - 33) + null(V_NOTRAIT - 43) + null(V_NOTRAIT - 53) + null(V_NOTRAIT - 63)) = 1
    et
    NAPCR61 > V_ANTCR 
    
alors erreur A991;
