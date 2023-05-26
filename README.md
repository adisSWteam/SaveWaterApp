# ADIS Muroor Save Water (Hold That Drop) App
<img src="https://github.com/adisSWteam/SaveWaterApp/blob/master/assets/images/waterdrop.png?raw=true" width="200" alt="ADISSaveWaterApp_Logo">

---

## Templates


### - Template For Events JSON File
```json
{
    "Local": [
      {
        "event_name": "Local Event Name Goes Here",
        "description": "Description For The Event Goes Here",
        "image_url": "Image For The Event Goes Here"
      },
      {
        "event_name": "Local Event Name Goes Here - 2",
        "description": "Description For The Event Goes Here - 2",
        "image_url": "Image For The Event Goes Here - 2"
      }
    ],
    "Inter": [
      {
        "event_name": "International Event Name Goes Here",
        "description": "Description For The Event Goes Here",
        "image_url": "Image For The Event Goes Here"
      },
        {
            "event_name": "International Event Name Goes Here - 2",
            "description": "Description For The Event Goes Here - 2",
            "image_url": "Image For The Event Goes Here - 2"
        }
    ]
}
```

### - Template For Gallery JSON File
```json
[
    {
        "title": "Title For The Image",
        "link": "Image Link"
    },
    {
        "title": "Title For The Image - 2",
        "link": "Image Link - 2"
    }
]
```

### - Template For ENV File
```env
DB_URL=
EVENTS_URL=
PHOTO_URL=
```