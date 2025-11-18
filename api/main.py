from fastapi import FastAPI, HTTPException
from printing_Service import CupsPyService

app = FastAPI(title="CUPS API Server")

# Connect to the CUPS server inside docker compose
cups = CupsPyService(host="cups-server", port=631)


@app.get("/printers")
def list_printers():
    return cups.list_printers()


@app.get("/printers/{name}")
def get_printer(name: str):
    printer = cups.get_printer(name)
    if not printer:
        raise HTTPException(status_code=404, detail="Printer not found")
    return printer


@app.get("/printers/{name}/jobs")
def printer_jobs(name: str):
    return cups.get_printer_jobs(name)


@app.post("/printers/{name}/print")
def print_file(name: str, file_path: str):
    try:
        return cups.print_file(name, file_path)
    except FileNotFoundError:
        raise HTTPException(status_code=400, detail="File not found")


@app.get("/jobs")
def all_jobs():
    return cups.list_jobs()
