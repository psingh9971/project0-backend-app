from fastapi import APIRouter, Depends, HTTPException
from app.authentication.auth import get_current_user
router = APIRouter(tags=["IAM Service"])


@router.get("", name="Get User Details")
async def get_user_details(
        user = Depends(get_current_user)
):
    return {"user": "Parvinder singh"}

