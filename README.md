# Nomad World - BackEnd

Nomad World es un proyecto diseñado para entusiastas de viajar que desean explorar rutas de viaje compartidas por otros usuarios. La plataforma trabajará a modo de red social, esta permitirá a los usuario poder publicar el itinerario de sus viajes para así poder compartirlo con el resto de usuarios para inspirar a los usuario para sus próximos viajes.

## Authors
- [@AlbertDarchiev](https://github.com/AlbertDarchiev)
- [@DReino03](https://github.com/DReino03) 
- [@LorenzoDalmaau](https://github.com/LorenzoDalmaau)
- [@peronaOscar](https://github.com/peronaOscar)


## Bakcend project
- [Nomad World - Backend](https://github.com/AlbertDarchiev/NomadWorld_BackEnd/tree/main)

## FrontEnd Project

![App Screenshot](https://ik.imagekit.io/albertITB/readme/Nomad%20World.png?updatedAt=1708598106088) 


# Technologies
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)


# Instalar flutter en linux

**Descargar flutter sdk**

[Download sdk](https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.1-stable.tar.xz)

**Extrae el archivo descargado en una ubicación de tu elección**

```bash
cd ~/development
tar xf ~/Downloads/flutter_linux_vX.X.X-stable.tar.xz
```

***Agrega la herramienta de Flutter a tu ruta (PATH)**

```bash
export PATH="$PATH:`pwd`/flutter/bin"
```

**Verifica tu instalacion**

```bash
flutter doctor
```

# Configuracion Android Studio

**Instalacion de pluggins**

Para poder utilizar flutter debes intalar el plugin 'Flutter' y 'Dart' en tu proyecto. Para eso dirigete a `File>Settings>Plugins`

![Plugins](readme_assets\pluggins_flutter.png) 

**Pluggins recomendados**

Si tienes intencion de desarollar en flutter es recomentable usar el pluggin ´Flutter snippets´. Este pluggin te permitira autocompletar tu codigo con funciones exclusivas de flutter

![Plugins](readme_assets\extra_pluggins_flutter.png) 

**Indicar path de flutter SDK**

Dentro de Android Studio dirigete a ``File>Settings``, una vez en la pestaña dirigete en el menu de la derecha a ``Language & Frameworks>Flutter`` y indica el path de tu SDK de flutter, una vez echo aplica los cambios

![Plugins](readme_assets\flutter_path.png) 

# Compilar proyecto

**Clonar el repositorio de GitHub:**

    git clone https://github.com/LorenzoDalmaau/NomadWorld_Front-end_Flutter.git
    
**Compilar en antroid studio:**

Una vez clonado el el repositorio y despues de instalar flutter abrimos el IDE y hacemos un get de las dependencias, para ello abre el propio terminal del IDE y ejecuta el siguiente comando:

```bash
flutter pub get
```

Una vez echo esto ya puedes compilar el proyecto

![Android studio](readme_assets\run_app_android.png) 


# Futuras ampliaciones

Con NomadWorld tambien se han tenido en cuenta propuestas a futuro para que asi la app pueda crecer y llegar a la gente con mas facilidad, entre las futuras ampliaciones pensadas se pueden destacar:

- **Comentarios**
    En un futuro nos gustaria implementer comentarios tanto en las rutas como en las localizaciones para que asi los usuarios puedan dar un feedback a la publicaciones

- **Likes**
    Nos gustaria implemenentar un sistema de likes para que los usuarios puedan valorar los viajes del resto de personas

- **Chat**
    Otra idea a implementar seria añadir un chat entre usuarios para poder comunicarse entre ellos y poder hablar de sus viiajes


# App demo

[![Nomad demo](./readme_assets\nomad_logo.png)](https://drive.google.com/file/d/1-0WSB1DX14HbdtZ1kP_jioV7YqaoEEZ8/view)