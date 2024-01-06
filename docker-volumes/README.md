#  Тестирование потерь производительности ввода-вывода в docker.

Воспроизводимость эксперимента базируется прежде всего на Yandex Cloud, поэтому в проект включены файлы terraform и ansible.

[Эксперимент в формате jupyter notebook](docker_vs_host-non-replicated.ipynb)


## Воспроизведение

Роли ansible необходимо установить:
```
cd ansible
ansible-galaxy install -r requirements.yml
```

Ansible запускается автоматически в виде terraform provisioner local-exec.

Запускать можно просто набор файлов из каталога terraform.
Помимо реквизитов Yandex Cloud, нужен еще и домен делегированный на CloudFlare и реквизиты доступа к этому сервису.


## Тестирование docker


Собираем образ:
```
docker build .  -t pavlozt/deb-fio:latest
```

Запускаем образ
```
docker run -v /data/:/data/ -v ./task.ini:/data/task.ini -it pavlozt/deb-fio:latest bin/bash
```
Дальнейшие манипуляции, запуск fio и копирование файлов с результатами осуществляется вручную.
