from ..helper.ext_utils.bot_utils import COMMAND_USAGE, new_task
from ..helper.ext_utils.help_messages import (
    YT_HELP_DICT,
    LEECH_HELP_DICT,
)
from ..helper.telegram_helper.button_build import ButtonMaker
from ..helper.telegram_helper.message_utils import (
    edit_message,
    delete_message,
    send_message,
)
from ..helper.ext_utils.help_messages import help_string


@new_task
async def arg_usage(_, query):
    data = query.data.split()
    message = query.message
    await query.answer()
    if data[1] == "close":
        return await delete_message(message, message.reply_to_message)
    pg_no = int(data[3])
    if data[1] == "nex":
        if data[2] == "leech":
            await edit_message(
                message, COMMAND_USAGE["leech"][0], COMMAND_USAGE["leech"][pg_no + 1]
            )
        elif data[2] == "yt":
            await edit_message(
                message, COMMAND_USAGE["yt"][0], COMMAND_USAGE["yt"][pg_no + 1]
            )
    elif data[1] == "pre":
        if data[2] == "leech":
            await edit_message(
                message, COMMAND_USAGE["leech"][0], COMMAND_USAGE["leech"][pg_no + 1]
            )
        elif data[2] == "yt":
            await edit_message(
                message, COMMAND_USAGE["yt"][0], COMMAND_USAGE["yt"][pg_no + 1]
            )
    elif data[1] == "back":
        if data[2] == "l":
            await edit_message(
                message, COMMAND_USAGE["leech"][0], COMMAND_USAGE["leech"][pg_no + 1]
            )
        elif data[2] == "y":
            await edit_message(
                message, COMMAND_USAGE["yt"][0], COMMAND_USAGE["yt"][pg_no + 1]
            )
    elif data[1] == "leech":
        buttons = ButtonMaker()
        buttons.data_button("Back", f"help back l {pg_no}")
        button = buttons.build_menu()
        await edit_message(message, LEECH_HELP_DICT[data[2]], button)
    elif data[1] == "yt":
        buttons = ButtonMaker()
        buttons.data_button("Back", f"help back y {pg_no}")
        button = buttons.build_menu()
        await edit_message(message, YT_HELP_DICT[data[2]], button)


@new_task
async def bot_help(_, message):
    await send_message(message, help_string)
