# astroconsp

На этой ветке скорее всего половина документов не соберутся.
Это -- нормально. Мы меняем структуру. За стабильностью добро пожаловать в `master`.

### Build-time deps
- texlive-core
- latexmk

Надо б разобраться потом поточнее

### Build process

```sh
$ make
```

Пдфка окажется в pdf/

```sh 
$ make clean # вызовет latexmk -C
```
