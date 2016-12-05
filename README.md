# namespaces-popper
Experiments for testing namespace affinity.

## Visualization

Drop this into the Graphite dasbhoard:

```json
[
  {
    "title": "Throughput vs. Network Utilization",
    "drawNullAsZero": "true",
    "target": [
      "issdm-12.mds_server.handle_client_request_tput",
      "secondYAxis(issdm-12.nettotals.kbin)",
      "secondYAxis(issdm-12.nettotals.kbout)"
    ]
  },
  {
    "areaMode": "stacked",
    "title": "Throughput vs. CPU Utilization",
    "drawNullAsZero": "true",
    "yMax": "20000",
    "target": [
      "issdm-12.mds_server.handle_client_request_tput",
      "secondYAxis(issdm-12.cputotals.user)",
      "secondYAxis(issdm-12.cputotals.sys)"
    ]
  },
  {
    "drawNullAsZero": "true",
    "yMaxRight": "2000000",
    "target": [
      "issdm-12.mds_server.handle_client_request_tput",
      "secondYAxis(issdm-12.mds_mem.ino+)",
      "secondYAxis(issdm-12.mds_mem.ino-)"
    ],
    "title": "Throughput vs. Inodes(+, -)"
  },
  {
    "target": [
      "",
      "issdm-12.mds.inodes",
      "issdm-12.mds.inodes_pin_tail",
      "issdm-12.mds.inodes_bottom",
      "issdm-12.mds.inodes_pinned",
      "issdm-12.mds.inodes_with_caps",
      "issdm-12.mds.inodes_top"
    ],
    "title": "Cached Inodes"
  },
  {
    "hideLegend": "true",
    "lineMode": "connected",
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
    "title": "Journal Activity"
  },
  {
    "hideLegend": "true",
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
    ]
  },
  {
    "target": [
      "secondYAxis(issdm-12.mds_server.handle_client_request)"
    ]
  }
]
```
