import os

from camoufox.server import launch_server

launch_server(
    geoip=True,
    port=int(os.environ.get("WS_PORT", "59001")),
    ws_path=os.environ.get("WS_PATH", "camoufox"),
)
