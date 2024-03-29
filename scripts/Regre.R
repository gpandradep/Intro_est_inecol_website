##%######################################################%##
#                                                          #
####                  Regresi�n simple                  ####
#                                                          #
##%######################################################%##

# R.1 ---------------------------------------------------------------------

# Llamo los datos, los coloco en un dataframe y convierto las columnas en variables

reg.data<-read.table("tannin.txt",header=T)
attach(reg.data)
names(reg.data)

# grafico 
par(mfrow=c(1,1))
plot(tannin,growth,pch=16)
	
# �La tendencia  de la variable de respuesta es a incrementar o a disminuir con la explicatoria?
 
# tendencia a disminuir
 
# �Es factible que los datos sean explicados por una l�nea horizontal? H0.
  
abline(mean(growth),0)
  
# la H0 no parece factible, entonces b es probablemente dif de 0 y negativa

# �Si existe una tendencia es recta o curva?

# relaci�n recta,  entonces proponemos  el modelo y=a+bx+e

# �La dispersi�n de los datos es uniforme a lo largo de la l�nea o cambia sistem�ticamente con la variable explicatoria?. 

# Dispersi�n muy uniforme, la ordenada al origen es dif de 0 entonces a es prob mayor que 0.


# �a ojo cuales son los valores de a  y b?  Como podemos hacer este proceso sistem�tico y preciso?

# C.1


# R.2 ---------------------------------------------------------------------

# Y la variaci�n total de y es la dispersi�n de los datos alrededor de  y  barra. 
# La Suma de Cuadrados Total es SCT=Sumatoria (y-ybarra)^2

for (i in 1:9) lines(c(tannin[i],tannin[i]),c(growth[i],mean(growth)))

# La mejor recta ajustada por el m�todo de m�nimos cuadrados es aquella que minimiza la Suma de Cuadrados de las desviaciones de los valores de y de la l�nea ajustada ^y, SCE=Sumatoria(y - ^y)^2


plot(tannin,growth,pch=16)
abline(lm(growth~tannin))

ysomb <- predict(lm(growth ~ tannin))

for(i in 1:9)
lines(c(tannin[i], tannin[i]), c(growth[i], ysomb[i]))

# C.2

# R.3 ---------------------------------------------------------------------

# Ahora bien, una tercera cantidad es la Suma de Cuadrados de la Regresi�n (es decir del efecto de la variable predictora) 
# SCR = SCTotal - SCError

plot(tannin, growth, type = "n")
abline(mean(growth), 0)
modelito <- lm(growth ~ tannin)
abline(modelito)
for(i in 1:9)
lines(c(tannin[i], tannin[i]), c(mean(growth), predict(modelito)[i]))
points(tannin, predict(modelito), pch = 16)
points(tannin, growth)

# C.3


# R.4 ---------------------------------------------------------------------

# Empezamos a ajustar los modelos: modelo nulo - solo la media

Nulo <- lm(growth ~ 1)
names(Nulo)
 
anova(Nulo)
Nulo$df.residual
Nulo$coefficients
Nulo$fitted.values
      
 
plot(tannin, growth)
abline(a=Nulo$coe, b=0)
abline(Nulo$coe, 0)

# Es decir solo se ha ajustado la media que no ofrece informaci�n importante

# Agregamos el efecto del tannin

Tanino <- update(Nulo, . ~ . + tannin)

Tanino

anova(Tanino)

Tanino$coefficients

summary(Tanino)

# O bien pedimos la secuencia de ajustes, que  produce estos cambios en devianza

anova(Nulo, Tanino)

summary(Tanino)

# Si queremos, podemos guardar los valores ajustados y los residuales en la base de datos: 

reg.data$ajustados <- fitted.values(Tanino)
reg.data$residuales <- residuals(Tanino)

reg.data	
	
# Para inspeccionar qu� tan bueno es el modelo existen algunos recursos gr�ficos donde se examinan la distribuci�n de los residuales y los puntos extremos que que pueden "cargar" el valor num�rico de los par�metros:

par(mfcol=c(2,2))
plot(Tanino)

# Examinamos un modelo sin el dato extremo:

Sindat7 <- lm(growth[-7] ~ tannin[-7])
summary(Sindat7)

# No ganamos gran cosa

# Para predecir valores usamos:

predict(Tanino, list(tannin =7.5))   

par(mfrow=c(1,1))
ls()
rm(list=ls(all=TRUE))


# Fin
	
