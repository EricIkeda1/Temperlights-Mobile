# Temperlights-Mobile

**Temperlights-Mobile** é uma aplicação desenvolvida com **Flutter**, voltada para a digitalização e reconhecimento inteligente de etiquetas, estampas e códigos de barras. Utiliza **OCR (Reconhecimento Óptico de Caracteres)** e leitura de **códigos de barras** para extrair dados de imagens capturadas pela câmera ou selecionadas da galeria.

A aplicação está integrada ao **Supabase** para autenticação de usuários e armazenamento em nuvem. É compatível com múltiplas plataformas: **Android**, **Web**, **Windows**, **Linux** e **macOS**.

---

## Funcionalidades

- Captura de imagens pela câmera ou galeria do dispositivo
- Reconhecimento de texto com OCR (Google ML Kit ou alternativa)
- Leitura de códigos de barras
- Visualização de dataset de imagens (estampas de referência)
- Integração com Supabase (login, armazenamento e autenticação)
- Compatibilidade multiplataforma: Android, Web, Desktop (Windows, Linux, macOS)
- Upload e leitura de dados na nuvem

---

# 1. Clone o repositório
git clone https://github.com/EricIkeda1/Temperlights-Mobile.git
cd Temperlights-Mobile/Mobile/scanocr/

# 2. Instale as dependências
flutter pub get

# 3. Execute o app no emulador ou dispositivo
flutter run

# Executar no navegador (Web)
flutter run -d chrome

# Executar no Windows
flutter run -d windows

# Executar no Linux
flutter run -d linux

# Executar no macOS
flutter run -d macos

---

## Estrutura de Pastas

```text
scanocr/
├── lib/
│   ├── main.dart                  Entrada principal do aplicativo
│   ├── screens/                   Telas da aplicação (home, OCR, scanner, resultado)
│   ├── services/                  Implementação dos serviços de OCR e código de barras
│   ├── supabase/                  Cliente Supabase para autenticação e dados
│   └── assets/references/         Dataset de imagens utilizadas pelo OCR
├── android/                       Código nativo para Android (Kotlin)
├── ios/                           Projeto iOS (Swift)
├── linux/                         Suporte e build para Linux
├── macos/                         Suporte para macOS
├── windows/                       Projeto desktop para Windows
├── web/                           Arquivos para execução via navegador
├── test/                          Testes automatizados (unitários e de widget)
├── pubspec.yaml                   Arquivo de configuração do Flutter
├── pubspec.lock                   Versões travadas das dependências
├── README.md                      Este arquivo
└── .gitignore, .metadata          Arquivos de controle do projeto

