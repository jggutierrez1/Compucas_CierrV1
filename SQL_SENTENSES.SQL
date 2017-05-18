  SELECT 
		:cCTA_VTA_GENE 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y")	AS fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.op_total),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())				AS horatran, 
     	0.00          			AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_efectivo + op.op_cheque,2)) >= ABS(ROUND(op.op_total,2)),1,2) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo + op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 				AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"V"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ROUND(ABS(op.op_total),2)>0.00)
     	AND   (:cCTA_VTA_GENE<>'')
UNION 
  SELECT 
		:cCTA_VTA_EXEN 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y")	AS fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.op_total),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_efectivo + op.op_cheque,2)) >0.00, 0.00, ROUND(ABS(op.op_total),2) ) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo+op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 		AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"V"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ABS(ROUND(op.op_itbms,2))=0.00)
     	AND   (:cCTA_VTA_EXEN<>'')
UNION 
  SELECT 
		:cCTA_VTA_GRAV 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y")	AS fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.op_total),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 0.00, ROUND(ABS(op.op_total),2) ) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo+op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 		AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"V"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ABS(ROUND(op.op_itbms,2))>0.00)
     	AND   (:cCTA_VTA_GRAV<>'')
UNION     	
SELECT 
		:cCTA_VTA_IMP07 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y")	AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.emp_imp1),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ABS(op.emp_imp1) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
    	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ABS(ROUND(op.emp_imp1,2))>0.00)
     	AND   (:cCTA_VTA_IMP07<>'')
UNION
   SELECT 
		:cCTA_VTA_IMP10 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.emp_imp2),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ABS(op.emp_imp2) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ABS(ROUND(op.emp_imp2,2))>0.00)
     	AND   (:cCTA_VTA_IMP10<>'')
UNION 
   SELECT 
		:cCTA_VTA_IMP15 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y")	AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("CTE: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=16,"D","C")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.emp_imp3),2)	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ABS(op.emp_imp3) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ( (op.op_tipo=2) OR (op.op_tipo=13) OR (op.op_tipo=14) OR (op.op_tipo=16) ) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
    	AND   (op.ci_op_idz  =:cZET_ID)
     	AND   (ABS(ROUND(op.emp_imp3,2))>0.00)
     	AND   (:cCTA_VTA_IMP15<>'')
UNION 
   SELECT 
		:cCTA_CMP_GENE 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 					AS actsaldo, 
     	ROUND(ABS(op.op_total),2) 	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_efectivo + op.op_cheque,2)) >0.00, 0.00, ROUND(ABS(op.op_total),2) ) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo + op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 		AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ROUND(ABS(op.op_total),2)>0.00)
     	AND   (:cCTA_CMP_GENE<>'')
UNION
   SELECT 
		:cCTA_CMP_EXEN 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 					AS actsaldo, 
     	ROUND(ABS(op.op_total),2) 	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_efectivo + op.op_cheque,2)) >0.00, 0.00, ROUND(ABS(op.op_total),2) ) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo + op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 		AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ABS(ROUND(op.op_itbms,2))=0.00)
     	AND   (:cCTA_CMP_EXEN<>'')
UNION
   SELECT 
		:cCTA_CMP_GRAV 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 					AS actsaldo, 
     	ROUND(ABS(op.op_total),2) 	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	IF(ABS(ROUND(op.op_credito,2)) >0.00, 2 ,1)	AS fpago, 
     	IF(ABS(ROUND(op.op_efectivo + op.op_cheque,2)) >0.00, 0.00, ROUND(ABS(op.op_total),2) ) AS pgocash, 
		CASE
		WHEN ( (ABS(ROUND(op.op_efectivo,2)) >0.00) AND (ABS(ROUND(op.op_cheque,2))>0.00) AND (ABS(ROUND(op.op_efectivo + op.op_cheque,2))>0.00) ) THEN "05"
		WHEN ABS(ROUND(op.op_efectivo,2))>0.00 THEN "01"
		WHEN ABS(ROUND(op.op_cheque  ,2))>0.00 THEN "02"
		WHEN ABS(ROUND(op.op_tdebito ,2))>0.00 THEN "03"
		WHEN ABS(ROUND(op.op_tcredito,2))>0.00 THEN "04"
		ELSE
			"06"
		END 		AS tipotuno,
     	"" 					AS tipotdos, 
     	ROUND(ABS(op.op_total),2) AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ABS(ROUND(op.op_itbms,2))>0.00)
     	AND   (:cCTA_CMP_GRAV<>'')
UNION 
   SELECT 
		:cCTA_CMP_IMP07 AS codigo,
     	1 					AS secuen, 
     	5					AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 		AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") 	AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 				  				AS actsaldo, 
     	ROUND(ABS(op.emp_imp1),2) 	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ROUND(ABS(op.emp_imp1),2) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ABS(ROUND(op.emp_imp1,2))>0.00)
     	AND   (:cCTA_CMP_IMP07<>'')
UNION 
   SELECT 
		:cCTA_CMP_IMP10 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.emp_imp2),2)  AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ROUND(ABS(op.emp_imp2),2) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ABS(ROUND(op.emp_imp2,2))>0.00)
     	AND   (:cCTA_CMP_IMP10<>'')
UNION 
   SELECT 
		:cCTA_CMP_IMP15 	AS codigo,
     	1 						AS secuen, 
     	5						AS tipo, 
     	DATE_FORMAT(NOW(), "%d%m%Y") 			AS documento, 
     	DATE_FORMAT(op.op_fecha,"%d/%m/%Y") AS  fecha, 
     	DATE_FORMAT(now(),"%d/%m/%Y") 		AS fecval, 
     	CONCAT("FACT ESTAC(",op.op_estacion,")/DOC(",op.op_num_corre,")") AS detalle, 
     	CONCAT("PRV: ",op_id_cliente,"/",op_nombre) AS detalle2, 
     	IF(op.op_tipo=19,"C","D")	AS partida, 
     	0.00 								AS actsaldo, 
     	ROUND(ABS(op.emp_imp3),2) 	AS valor, 
     	0.00 					AS nvosaldo, 
     	"S" 					AS actualizo, 
     	"JOH"					AS usuario, 
     	TIME(NOW())			AS horatran, 
     	0.00          		AS intepago, 
     	0.00					AS sctaref, 
     	""						AS ultipago, 
     	0						AS reglibre, 
     	1 						AS fpago, 
     	ROUND(ABS(op.emp_imp3),2) 	AS pgocash, 
     	"01"           	AS tipotuno, 
     	"" 					AS tipotdos, 
     	0.00 					AS abonot, 
     	"" 					AS socioant, 
     	0.00     			AS cuenta1, 
     	"I"					AS coditran 
     	FROM operacion op 
     	WHERE ((op.op_tipo=1) OR (op.op_tipo=19)) 
     	AND   (op.suc_id     =:cSUC_ID) 
     	AND   (op.op_estacion=:cEST_ID) 
     	AND   (DATE_FORMAT(op.op_fechas,"%Y-%m-%d") =:cZFECHA)
     	AND   (ABS(ROUND(op.emp_imp3,2))>0.00)
     	AND   (:cCTA_CMP_IMP15<>'')