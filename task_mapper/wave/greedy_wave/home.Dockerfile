FROM python:3.5
RUN pip install flask

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ADD task_mapper/wave/greedy_wave/home/requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt

COPY task_mapper/wave/greedy_wave/home/master_greedy.py /master.py

RUN mkdir -p DAG

COPY task_mapper/wave/greedy_wave/home/start.sh /


ADD jupiter_config.ini /jupiter_config.ini

ADD app_specific_files/network_monitoring_app_dag/configuration.txt DAG/DAG_application.txt
ADD app_specific_files/network_monitoring_app_dag/input_node.txt DAG

EXPOSE 8888

RUN chmod +x /start.sh

WORKDIR /

CMD ["./start.sh"]
