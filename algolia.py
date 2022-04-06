import os, json
from algoliasearch.search_client import SearchClient


class Algolia:

    path = os.path.abspath(os.path.join(os.path.dirname(__file__), 'public', 'index' + '.json'))

    def run(self):
        application_id = os.environ.get('ALGOLIA_APP_ID')
        api_key = os.environ.get('ALGOLIA_API_KEY')
        index = os.environ.get('ALGOLIA_INDEX', 'Letsautomate.it')
        client = SearchClient.create(application_id, api_key=api_key)
        index = client.init_index(index)
        with open(self.path) as f:
            index.save_objects(json.load(f))

Algolia().run()
