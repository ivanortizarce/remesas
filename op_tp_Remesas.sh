#!/bin/bash
#remesas editadas para tarea de GIT
# +-------------------------------------------------------------+
# | Autor: IOA							|
# | Proposito: Script de control para ejecucion de remesas	|
# | Fecha: 25/08/2015						|
# | 								|
# | Modificacion: 27/10/2015					|
# | Cambios: Crear ZIP por cliente y moverlo a dir publico	|
# | de webserver para su descarga				|
# +-------------------------------------------------------------+
#

LOGFILE="/opt/OP_TP_Remesas/log/OP_TP_Remesas-`date "+%F"`.log"
cd /opt/OP_TP_Remesas/bin/
echo "----------------------------------------------------------------------------" >> $LOGFILEi
echo "[Inicia proceso: `date "+%k:%M:%S"` ]" >> $LOGFILE
rm -f /var/www/html/pub/OP_TP_Remesas*
echo "Remesas al dia: `date -d "-1 days" +%d-%m-%Y`" > mail.html
salidaP0=`./op_tp_p0.php`
echo " Se van a procesar $salidaP0 remesas" >> $LOGFILE
./op_tp_p1.php $salidaP0
salidaP2=`./op_tp_p2.php`
if [ $salidaP2 -eq "1" ]; then
	echo " Tabla borrada exitosamente" >> $LOGFILE
else
	echo " Tabla no borrada" >> $LOGFILE
fi

#Procesamiento de archivos
#BANOBRAS
RB=`ls ../csv/bano/ | wc -l`
if [ $RB -eq "0" ]; then
	echo " No se procesaron remesas de BANOBRAS" >> $LOGFILE
else
	ZIPFILE="OP_TP_RemesasBANO-`date "+%F"`.zip"
	echo " $RB remesas se van a agregar al archivo $ZIPFILE" >> $LOGFILE
	echo "  https://192.168.1.16/pub/$ZIPFILE" >> mail.html
	ls ../csv/bano/ | grep .csv |awk -F " " '{ print "../csv/bano/"$1  }'|xargs zip ../csv/bano/$ZIPFILE 1> /dev/null
	if [ $? -eq 0 ]; then
		echo " Se creo OK el archivo $ZIPFILE" >> $LOGFILE
		rm -f ../csv/bano/*.csv
		if [ $? -eq 0 ]; then
			echo " Archivos borrados exitosamente" >> $LOGFILE
		else
			echo " Error al borrar los archivos" >> $LOGFILE
		fi
		mv ../csv/bano/$ZIPFILE /var/www/html/pub/
		if [ $? -eq 0 ]; then
			echo " $ZIPFILE se movio OK a la ruta: /var/www/html/pub/" >> $LOGFILE
		else
			echo " Error al mover el archivo $ZIPFILE" >> $LOGFILE
		fi
	else
		echo " Error al comprimir los archivos..." >> $LOGFILE
	fi
fi


#Procesamiento de archivos
#SAE
RB=`ls ../csv/sae/ | wc -l`
if [ $RB -eq "0" ]; then
	echo " No se procesaron remesas de SAE" >> $LOGFILE
else
	ZIPFILE="OP_TP_RemesasSAE-`date "+%F"`.zip"
	echo " $RB remesas se van a agregar al archivo $ZIPFILE" >> $LOGFILE
	echo "  https://192.168.1.16/pub/$ZIPFILE" >> mail.html
	ls ../csv/sae/ | grep .csv |awk -F " " '{ print "../csv/sae/"$1  }'|xargs zip ../csv/sae/$ZIPFILE 1> /dev/null
	if [ $? -eq 0 ]; then
		echo " Se creo OK el archivo $ZIPFILE" >> $LOGFILE
		rm -f ../csv/sae/*.csv
		if [ $? -eq 0 ]; then
			echo " Archivos borrados exitosamente" >> $LOGFILE
		else
			echo " Error al borrar los archivos" >> $LOGFILE
		fi
		mv ../csv/sae/$ZIPFILE /var/www/html/pub/
		if [ $? -eq 0 ]; then
			echo " $ZIPFILE se movio OK a la ruta: /var/www/html/pub/" >> $LOGFILE
		else
			echo " Error al mover el archivo $ZIPFILE" >> $LOGFILE
		fi
	else
		echo " Error al comprimir los archivos..." >> $LOGFILE
	fi
fi


#Procesamiento de archivos
#SisNOVA
RB=`ls ../csv/nova/ | wc -l`
if [ $RB -eq "0" ]; then
	echo " No se procesaron remesas de NOVA" >> $LOGFILE
else
	ZIPFILE="OP_TP_RemesasNOVA-`date "+%F"`.zip"
	echo " $RB remesas se van a agregar al archivo $ZIPFILE" >> $LOGFILE
	echo "  https://192.168.1.16/pub/$ZIPFILE" >> mail.html
	ls ../csv/nova/ | grep .csv |awk -F " " '{ print "../csv/nova/"$1  }'|xargs zip ../csv/nova/$ZIPFILE 1> /dev/null
	if [ $? -eq 0 ]; then
		echo " Se creo OK el archivo $ZIPFILE" >> $LOGFILE
		rm -f ../csv/nova/*.csv
		if [ $? -eq 0 ]; then
			echo " Archivos borrados exitosamente" >> $LOGFILE
		else
			echo " Error al borrar los archivos" >> $LOGFILE
		fi
		mv ../csv/nova/$ZIPFILE /var/www/html/pub/
		if [ $? -eq 0 ]; then
			echo " $ZIPFILE se movio OK a la ruta: /var/www/html/pub/" >> $LOGFILE
		else
			echo " Error al mover el archivo $ZIPFILE" >> $LOGFILE
		fi
	else
		echo " Error al comprimir los archivos..." >> $LOGFILE
	fi
fi



#Procesamiento de archivos
#PRONOSTICOS
RB=`ls ../csv/prono/ | wc -l`
if [ $RB -eq "0" ]; then
	echo " No se procesaron remesas de BANOBRAS" >> $LOGFILE
else
	ZIPFILE="OP_TP_RemesasPRONO-`date "+%F"`.zip"
	echo " $RB remesas se van a agregar al archivo $ZIPFILE" >> $LOGFILE
	echo "  https://192.168.1.16/pub/$ZIPFILE" >> mail.html
	ls ../csv/prono/ | grep .csv |awk -F " " '{ print "../csv/prono/"$1  }'|xargs zip ../csv/prono/$ZIPFILE 1> /dev/null
	if [ $? -eq 0 ]; then
		echo " Se creo OK el archivo $ZIPFILE" >> $LOGFILE
		rm -f ../csv/prono/*.csv
		if [ $? -eq 0 ]; then
			echo " Archivos borrados exitosamente" >> $LOGFILE
		else
			echo " Error al borrar los archivos" >> $LOGFILE
		fi
		mv ../csv/prono/$ZIPFILE /var/www/html/pub/
		if [ $? -eq 0 ]; then
			echo " $ZIPFILE se movio OK a la ruta: /var/www/html/pub/" >> $LOGFILE
		else
			echo " Error al mover el archivo $ZIPFILE" >> $LOGFILE
		fi
	else
		echo " Error al comprimir los archivos..." >> $LOGFILE
	fi
fi

chown webserver:webserver  -R /var/www/html/pub/
if [ $? -eq 0 ]; then
	echo " Se cambio el prpietario OK" >> $LOGFILE
else
	echo " Error al cambiar el propietario" >> $LOGFILE
fi

#Notificacion
echo -e "\n\n\n\n\n\nEste correo se ha generado automaticamente, por favor no responderlo." >> mail.html
echo -e "\n\nTecnologías de la Información | MediAccess\n\n\n" >> mail.html
echo "Supported by: `uname -o`" >> mail.html
mail -s "Proceso Remesas" aqui.va.la.o.las.direcciones.de.correo@example.com < mail.html




#echo $salidaP1
echo "[Termina proceso: `date "+%k:%M:%S"` ]" >> $LOGFILE
echo "----------------------------------------------------------------------------" >> $LOGFILE
