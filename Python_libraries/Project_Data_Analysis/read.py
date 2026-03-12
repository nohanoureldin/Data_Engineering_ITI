import requests
import pandas as pd


def fetch_api_data():

    limit = 30
    total = 0
    skip = 0
    listpd = []
    page = 1

    while True:
        url = f'https://dummyjson.com/users?limit={limit}&skip={skip}'
        response = requests.get(url)

        data = response.json()['users']
        total = response.json()['total']
#### I Normalized The Data first to flatten the nested structure and make it easier to work with ####
        listpd.append(pd.json_normalize(data))

        print(f"page {page} loaded!")

        skip += limit
        page += 1

        if skip >= total:
            break

    print("data fetched successfully")

    df = pd.concat(listpd, ignore_index=True)

    df.to_csv('users.csv', index=False)

    print("data saved successfully")

    return df


if __name__ == "__main__":
    fetch_api_data()
