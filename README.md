Esporty App
=============

**Procurando o Server Side? [Clique aqui](https://github.com/ghvillasboas/EsportyAppServerSide)**

Este é o app hipotético gerado pelo código exemplo apresentado na [Trilha iOS do TDC SP 2014](http://www.thedevelopersconference.com.br/tdc/2014/saopaulo/trilha-ios), Melhorando a experiência do usuário usando Background Fetching, por [George Villasboas](https://twitter.com/ghvillasboas).

**A keynote da talk, em PDF, pode ser [baixada aqui](https://drive.google.com/file/d/0B0KwdWz7zxc2a0QwNjRmb2ZYQzg/edit?usp=sharing)**

Ele serve para simular um serviço remoto usado para alimentar o aplicativo Esporty (App fictício de compartilhamento de fotos de esportes radicais) e enviar Remote Notifications para mostrar o funcionamento de background fetches.

O propósito é mostrar o funcionamento das APIs de background fetch em um cenário real.

![Esporty App](https://raw.github.com/ghvillasboas/EsportyApp/master/images/esporty1.png)

## Como instalar

1. Clone este repositório e execute em seu Xcode 5+

2. Instale o server side do aplicativo localmente (afinal estamos tratando de fetchings remotos ;) )
Mais informações e código do server side você encontra neste repositório: https://github.com/ghvillasboas/EsportyAppServerSide

3. Crie os seus certificados de push notification no Apple Developer Portal e também os provisioning profiles de development para o app. Detalhes em: https://developer.apple.com/notifications/

4. Configure o endereço do server side no header do arquivo Models/EsportyPostRemoteFetcher.h ([linha 17](https://github.com/ghvillasboas/EsportyApp/blob/master/Esporty/EsportyPostRemoteFetcher.h#L17))

5. Execute no device ou simulador.

6. Teste o background fetch usando o menu Debug > Simulate Background Fetch do XCode e também pelo Schema "Esporty - Background Fetch" para testar o cenário em que o app não está em execução.

7. Observe o console pelos resultados.

Background Fetch
```
    2014-08-10 01:55:56.697 Esporty[92078:607] -[AppDelegate application:performFetchWithCompletionHandler:]
    2014-08-10 01:55:57.958 Esporty[92078:607] Posts atualizados: 3
```

Remote Notification
```
    2014-08-10 01:55:56.697 Esporty[92078:607] -[AppDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:]
    2014-08-10 01:55:57.958 Esporty[92078:607] Posts atualizados: 1
```

## Dicas

- Certifique de assinar seu app com o provisioning profile de desenvolvimento para que o serviço de push notification funcione adequadamente, conforme imagem abaixo.

![Code signing](https://raw.github.com/ghvillasboas/EsportyApp/master/images/esporty2.png)

- No Developer Portal, configure ao menos o developer certificate do serviço de push notification.

## Configuração testada

- OSX 10.9+
- Xcode 5+
- iOS 7.1+
- Esporty App Server Side 0.1: https://github.com/ghvillasboas/EsportyAppServerSide

## Perguntas?

Só abrir um issue.

## Colaborações?

Dê um pull request.

Enjoy!
