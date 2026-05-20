from fastapi import APIRouter, Depends, HTTPException
from app.api.v1.endpoints import (iam)
v1_router = APIRouter(prefix="/api/v1")

v1_router.include_router(iam.router, prefix="/iam")


@v1_router.get("/demo", tags=["demo"])
async def demo():
    return {"message": "Demo route is working"}
