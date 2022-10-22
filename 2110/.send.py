import asyncio
import sys
from aiogram import Bot, Dispatcher, types, executor
from aiogram.types import InputFile

bot = Bot(token = "5333115681:AAGXfCQUp97Xwbaa7ufDVhTkNU7UPubXCjc")
dp = Dispatcher(bot)
NAZAROFF_ID= "581853528"

async def send_photo():
    # old style:
    # await bot.send_message(message.chat.id, message.text)
    file_path=f"./photos/last.jpg"
    await bot.send_photo(chat_id=NAZAROFF_ID, photo=InputFile(file_path))


loop = asyncio.get_event_loop()
loop.run_until_complete(send_photo())
loop.close()


