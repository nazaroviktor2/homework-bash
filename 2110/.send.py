import asyncio
from aiogram import Bot, Dispatcher
from aiogram.types import InputFile

bot = Bot(token = "YOUR_TELEGRAM_BOT_TOKEN")
dp = Dispatcher(bot)
USER_ID= "YOUR_TELEGRAM_USER_ID"

async def send_photo():
    # old style:
    # await bot.send_message(message.chat.id, message.text)
    file_path=f"./photos/last.jpg"
    await bot.send_photo(chat_id=USER_ID, photo=InputFile(file_path))


loop = asyncio.get_event_loop()
loop.run_until_complete(send_photo())
loop.close()


