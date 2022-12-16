import os
import json
import sys
import getopt

exampleFolderLocation = r""
outputLocation = r""
baseUrl = ""

arg_help = "{0} -f <folder> -u <url> -o <output>".format(sys.argv[0])

try:
    opts, args = getopt.getopt(sys.argv[1:], "hf:u:o:", ["help", "folder=",
                                                     "url=", "output="])
except:
    print(arg_help)
    sys.exit(2)

for opt, arg in opts:
    if opt in ("-h", "--help"):
        print(arg_help)  # print the help message
        sys.exit(2)
    elif opt in ("-f", "--folder"):
        exampleFolderLocation = arg
    elif opt in ("-u", "--url"):
        baseUrl = arg
    elif opt in ("-o", "--output"):
        outputLocation = arg

if not outputLocation:
    outputLocation = os.getcwd()

if not baseUrl:
    baseUrl = "{{FHIR_BASE_URL}}"

if not exampleFolderLocation:
    print("Need to provide a directory with sample data")
    sys.exit(2)

#build entry list and returns list

def  build_entries(resources):
    entries = []
    #loop through resources, pull id and populate fullUrl and request:url
    for x in resources:
        loadedJsonDict = json.loads(x)
        id = loadedJsonDict["id"]
        resourceType = loadedJsonDict["resourceType"]
        entry = {
            "fullUrl": f"{baseUrl}/{resourceType}/{id}",
            "resource": loadedJsonDict,
            "request": {
                "method": "PUT",
                "url": f"{resourceType}/{id}"
            }
        }
        entries.append(entry)
    return entries

#loads resource into string and adds to list
def extractFiles(directory):
    resources = []
    for x in directory:
        f = open(rf"{exampleFolderLocation}\{x}", encoding="utf8").read()
        #resources.append(json.loads(f))
        resources.append(f)
    return resources

folder = os.listdir(exampleFolderLocation)
resources = extractFiles(folder)
entries = build_entries(resources)

#example entries
"""
    {
      "fullUrl": "http://example.org/fhir/Patient/123",
      "resource": {
        "resourceType": "Patient",
        "id": "123",
        "text": {
          "status": "generated",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">Some narrative</div>"
        },
        "active": true,
        "name": [
          {
            "use": "official",
            "family": "Chalmers",
            "given": [
              "Peter",
              "James"
            ]
          }
        ],
        "gender": "male",
        "birthDate": "1974-12-25"
      },
      "request": {
        "method": "PUT",
        "url": "Patient/123"
      }
    }
"""

requestBody = {
  "resourceType": "Bundle",
  "id": "bundle-transaction",
  "meta": {
    "lastUpdated": "2022-12-22T01:43:30Z"
  },
  "type": "transaction",
  "entry": entries
}

newFile = open(outputLocation,'x')
newFile.write(json.dumps(requestBody, indent = 4))
newFile.close()