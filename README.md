# Volume Booster App

Aplicación Flutter que, al abrirse, fuerza el volumen del sistema en Windows al máximo y reproduce un sonido de inicio almacenado en `assets/audio/startup.wav`.

## Requisitos

- [Flutter](https://flutter.dev/docs/get-started/install) 3.13 o superior.
- Windows 10 u 11 para el ajuste automático del volumen (en otras plataformas la app solo reproducirá el sonido).

## Puesta en marcha

1. Ejecuta `flutter pub get` en la raíz del proyecto.
2. Conecta un dispositivo o inicia un emulador y lanza la app con `flutter run`.

## Personaliza el sonido

Reemplaza el archivo `assets/audio/startup.wav` por el audio que desees reproducir al iniciar la aplicación. Si cambias la ruta o el nombre del archivo, actualiza la entrada correspondiente en `pubspec.yaml`.

## Nota sobre el control de volumen

El incremento del volumen se realiza enviando múltiples eventos de teclado `VK_VOLUME_UP` mediante la API de Windows. Esto garantiza que el deslizador de volumen del sistema quede en su posición máxima.
