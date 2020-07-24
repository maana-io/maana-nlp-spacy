
FROM jgontrum/spacyapi:en_v2 AS spacy

WORKDIR /spacy
COPY ./ .

FROM tiangolo/uvicorn-gunicorn:python3.7
RUN pip install ariadne uvicorn gunicorn asgi-lifespan python-dotenv requests graphqlclient
WORKDIR /application
COPY --from=spacy /spacy /application/.

RUN chmod +x ./scripts/*
RUN pip install -r requirements.txt

RUN python -m spacy download en

RUN ls
EXPOSE 8990
CMD ./scripts/start.sh
