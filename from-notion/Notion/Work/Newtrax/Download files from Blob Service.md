---

---
```javascript
/api/v1/blobs/download?file_name_pattern=%2520221025_16%25.raw
so if you want do download all the files from a machine just call: /api/v1/blobs/download?file_name_pattern=ID_LH514%.raw
you can apply many filters based on the file name

year: /api/v1/blobs/download?file_name_pattern=ID_LH514_2023%.raw
month: /api/v1/blobs/download?file_name_pattern=ID_LH514_202304%.raw
day: /api/v1/blobs/download?file_name_pattern=ID_LH514_20230420%.raw etc.

[https://<environment-base-url>/api/blob-storage/api/v1/blobs/download/<download-id>](https://%3Cenvironment-base-url%3E/api/blob-storage/api/v1/blobs/%3Ccontainer-name%3E/%3Craw-file-name%3E%3E)
```

[http://10.0.18.54/api/blob-storage/api/v1/blobs/download?file_name_pattern=%25CMI409_202312%25.raw](http://10.0.18.54/api/blob-storage/api/v1/blobs/download?file_name_pattern=%25CMI409%25.raw)

api/blob-storage