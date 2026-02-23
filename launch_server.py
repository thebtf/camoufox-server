import os

import camoufox.utils as _cu
from camoufox.server import launch_server

# Workaround for camoufox bug #457: proxy=None serialized as JSON null
# causes Playwright to throw "proxy: expected object, got null".
# Filter None values from launch_options before they reach Node.js.
_orig_launch_options = _cu.launch_options


def _filtered_launch_options(*args, **kwargs):
    opts = _orig_launch_options(*args, **kwargs)
    return {k: v for k, v in opts.items() if v is not None}


_cu.launch_options = _filtered_launch_options

launch_server(
    headless=True,
    geoip=True,
    port=int(os.environ.get("WS_PORT", "59001")),
    ws_path=os.environ.get("WS_PATH", "camoufox"),
)
