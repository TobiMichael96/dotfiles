import requests
import json
from datetime import datetime
import os
import sys


def get_sharelink(directory, filename, token):
    request_sharelink = requests.post(
        'https://seafile.tobiasmichael.de/api/v2.1/share-links/',
        data={'path': 'Screenshots/' + filename, 'repo_id': 'c0aa7493-64d8-4939-bb83-769cd338e5a1'},
        headers={'Authorization': 'Token {token}'.format(token=token), 'Accept': 'application/json; indent=4'}
    )

    if request_sharelink.status_code == 200:
        os.remove(directory + filename)
        response_json = json.loads(request_sharelink.content)
        os.system("echo '%s' | xclip -selection c" % response_json['link'])
        os.system("notify-send 'Screenshot' 'Link copied to clipboard!'")


def get_upload_link(url, token):
    resp = requests.get(
        url, headers={'Authorization': 'Token {token}'.format(token=token)}
    )
    return resp.json()


if __name__ == "__main__":
    # token
    file = open(os.path.expanduser('~') + '/.seafile', 'r')
    token = file.read().replace('\n', '')

    # library id
    upload_link = get_upload_link(
        'https://seafile.tobiasmichael.de/api2/repos/c0aa7493-64d8-4939-bb83-769cd338e5a1/upload-link/', token
    )

    # directory to save file in
    directory = os.path.expanduser('~') + '/Pictures/Screenshots/'

    # create file name
    current_date = datetime.now().strftime('%d-%m-%Y_%H-%M-%S')
    image_name = 'Screenshot_' + current_date + '.png'

    if not os.path.exists(directory):
        os.makedirs(directory)

    if len(sys.argv) <= 1:
        os.system('scrot -s ' + directory + image_name)
    elif sys.argv[1] == 'f':
        os.system('scrot ' + directory + image_name)

    response = requests.post(
        upload_link, data={'parent_dir': '/Screenshots'},
        files={'file': open(directory + image_name, 'rb')},
        headers={'Authorization': 'Token {token}'.format(token=token)}
    )

if response.status_code == 200:
    get_sharelink(directory, image_name, token)
