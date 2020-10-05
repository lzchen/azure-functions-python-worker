FROM mcr.microsoft.com/azure-functions/python:3.0-python3.6

RUN rm -rf /azure-functions-host/workers/python/3.6/LINUX/X64/azure_functions_worker

COPY azure_functions_worker /azure-functions-host/workers/python/3.6/LINUX/X64/azure_functions_worker

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    FUNCTIONS_WORKER_PROCESS_COUNT=1 \
    PYTHON_THREADPOOL_THREAD_COUNT=1 \
    FUNCTIONS_WORKER_RUNTIME_VERSION=3.6

COPY requirements.txt /
RUN pip install --upgrade pip
RUN pip install -r /requirements.txt

COPY . /home/site/wwwroot

CMD [ "/azure-functions-host/Microsoft.Azure.WebJobs.Script.WebHost" ]
