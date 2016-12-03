# namespaces-popper
Experiments for testing namespace affinity.

## Visualization

Drop this into the Graphite dasbhoard:

```json
[
  {
    "target": [
      "issdm-18.mds_server.handle_client_request",
      "issdm-15.mds_server.handle_client_request",
      "issdm-12.mds_server.handle_client_request"
    ],
    "lineMode": "connected"
  },
  {
    "target": [
      "issdm-12.cputotals.sys",
      "issdm-12.cputotals.user"
    ],
    "drawNullAsZero": "true"
  },
  {
    "target": [
      "issdm-12.nettotals.kbout",
      "issdm-12.nettotals.kbin"
    ],
    "areaMode": "stacked"
  },
  {
    "target": [
      "issdm-12.mds_server.handle_client_request_tput"
    ],
    "lineMode": "connected"
  },
  {
    "target": [
      "issdm-40.disktotals.writekbs",
      "issdm-34.disktotals.writekbs",
      "issdm-27.disktotals.writekbs",
      "issdm-29.disktotals.writekbs",
      "issdm-24.disktotals.writekbs",
      "issdm-14.disktotals.writekbs",
      "issdm-11.disktotals.writekbs",
      "issdm-1.disktotals.writekbs",
      "issdm-0.disktotals.writekbs"
    ],
    "hideLegend": "true",
    "areaMode": "stacked"
  },
  {
    "target": [
      "issdm-40.disktotals.readkbs",
      "issdm-34.disktotals.readkbs",
      "issdm-29.disktotals.readkbs",
      "issdm-27.disktotals.readkbs",
      "issdm-24.disktotals.readkbs",
      "issdm-11.disktotals.readkbs",
      "issdm-14.disktotals.readkbs",
      "issdm-1.disktotals.readkbs",
      "issdm-0.disktotals.readkbs"
    ],
    "hideLegend": "true"
  }
]
```
