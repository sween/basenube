irissession IRIS <<EOF
zn "%SYS"
Write \$SYSTEM.OBJ.Load("/iris-scm/scenarios/ciliumfhir/cls/Coruscant.InterSystems.FHIR.cls","ck")
//zn "HSLIB"
Set tSC = ##class(Coruscant.InterSystems.FHIR).Setup()
h
EOF