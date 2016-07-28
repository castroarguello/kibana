# Set up Kibana

  git clone git@github.com:castroarguello/kibana.git

  cd kibana/4.5/

  docker-compose build && docker-compose up -d

Log into the kibana instance:

  docker exec -it 45_kibana_1 bash

  Run the example import script:

    # /import-shakespeare.sh

Point the browser to the Kibana app:

  http://localhost:5601
