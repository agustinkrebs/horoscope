## Test del Horóscopo
### Explicación
Esta sencilla app web intenta medir empirícamente la validez del horóscopo (en particular, el horóscopo del día de Yolanda Sultana). El funcionamiento es híper sencillo: la root page (`/`) contiene el test, y luego se lleva a una página de resultados.  

El test consiste en intentar adivinar cuál, de las 12 posibles tarjetas, corresponde a la de su signo zodiacal (dado que se han removido los nombres). Las 12 tarjetas que se muestran corresponden al horoscopo diario de Yolanda Sultana, el cual es publicado todos los días en www.login.cl. La obtención de estos datos se hace mediante un request de tipo `GET` a la API `https://api.xor.cl/tyaas/`.

Luego de leer las 12 tarjetas, se le pide al usuario que declare cuál es su signo zodiacal, y que elija 3 tarjetas como candidatas a ser de su signo. Se decidió esto para darle una mayor chance al usuario de poder acertar.

Al apretar el botón "¡Veámos!", se redirije al usuario a una segunda página con el resultado del test (acertó o no acertó). Además, se muestran los resultados totales de las personas que han tomado el test, entregando porcentajes de aciertos.

En esta vista también se muestra el porcentaje teórico de aciertos si es que todas las personas eligieran aleatoriamente las 3 tarjetas. La comparación de este número con el anterior es el mensaje principal de esta pequeña app: ¿existen realmente patrones de comportamiento detrás del horóscopo y los signos del zodiaco?.

Por último, en esta vista se muestra cuál era la tarjeta real asociada al signo zodiacal del usuario, por si le ineteresa esa información.

### Motivación

Personalmente, debo admitir que le tengo "un poco de mala" al horóscopo y la popularidad que ha ido ganando últimamente. Siendo completamente honesto, siempre he creído que no hay ninguna "verdad por descubrir" detrás de esta práctica. Así, al ver esta API tan peculiar de horóscopos me pareció choro indagar en el tema, ocupando herramientas básicas de desarrollo y un trasfondo matemático. A pesar de mi aversión al horóscopo, creo importante poder validar/refutar hipótesis con datos, es por esto que surge este test. Al final, sería interesante comparar si las personas son capaces de, en cierta medida, identificar a su horóscopo meramente por su contenido (y no que esta identificación sea arbitraria y aleatoria). De esta manera, este prototipo busca identificar si existe este patrón comparándolo con una elección aleatoria. Por último, me gustaría mencionar que en la página de resultados me hubiese gustado poner algún mensaje más del tipo "já, se los dije, horoscopistas!", pero preferí mostrar solamente los datos para que cada usuario tome sus propias conclusiones. Además, quién sabe, quizás se podría comportar mejor que el caso aleatorio!

Como nota aparte, siempre he pensado que la tecnología es un medio para fines más importantes, y no un fin en sí mismo (no creo que haya que meter tecnología en todos lados porque sí). Así, creo que esta app, por muy pequeña y de juguete que sea, está alineada con ese principio. En particular, nos ayuda a validar/rechazar cosas que todavía no tenemos tan claras como sociedad.

### Implementación
Dada la simplicidad de la app, se cuenta con un modelo, un controlador y dos vistas.
El modelo corresponde a `Guess` el cual fue creado con el único fin de almacenar los números totales de los tests. Estos números se guardan en las columnas/atributos `total_guesses` y `correct_guesses`. Cabe mancionar que esta tabla solo tendrá una columna, dado que los totales se actualizarán en vez de ir añadiendo filas a la tabla (no se necesita ese detalle de información). Luego, en el controlador `HoroscopeController` se encuentra toda la lógica de manejo de vistas, consultas a la API externa, calculo de porcentajes, entre otros. Por último, en las dos vistas `results.html.erb` y `test.html.erb` sucede la interacción con el usuario.

Una posible mejora hubiese sido poder acceder a horóscopos pasados para hacer un análisis "a posteriori" para la identificación de tarjetas. Esto no se implementó dado que la API no tenía la posibilidad de acceder a datos pasados ("no hay forma de obtener horóscopos anteriores, porque es de mala suerte").
.
### Cómo correr la aplicación
Esta aplicación fue hecha ocupando Ruby on Rails, versión 2.5.1.
Para correrla debes tener instalado Ruby, SQLite3, Node.js y Yarn (más información en https://guides.rubyonrails.org/getting_started.html)
Luego, deberás correr (dentro de la carpeta madre del repositorio) los siguientes comandos consecutivamente:
```
bundle install
```
```
yarn install
```
```
rails db:create
```

```
rails db:migrate
```
```
rails server
```
Cualquier problema o feedback, enviar correo a akrebs2@uc.cl.

¡Saludos!
