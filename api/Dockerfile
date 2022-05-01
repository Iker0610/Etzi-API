# Start from a python image
FROM python:3.10

# Create a new directory to allocate our API
WORKDIR /etzi

# Prepare requirements
#RUN \
 #apk add --no-cache postgresql-libs && \
 #apk add --no-cache g++ && \
 #apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
 #apk add --no-cache --update musl-dev gcc libffi-dev

# Copy requirements and install
RUN pip install --upgrade pip

COPY requirements.txt /etzi/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /etzi/requirements.txt

# Clear
#RUN  apk --purge del .build-deps

# Copy API project
COPY app /etzi/app

# Run uvicorn server with our API on port 80
CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0"]
