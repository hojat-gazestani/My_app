# My_app
* Microservice project

```bash
git clone https://github.com/hojat-gazestani/My_app.git && cd My_app/
source myapp/bin/activate

cd myproject
docker build  -t my_app .
docker run -d --hostname Myapp10 -p 8010:8001 my_app
```