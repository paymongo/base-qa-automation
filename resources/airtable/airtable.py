from pyairtable import Table
from pyairtable.formulas import match

def delete(api_key, app_key, table_name, column_header, value):
    table = Table(api_key, app_key, table_name)
    formatted_records = []

    for records in table.iterate(page_size=100, formula=match({column_header: value}), fields=['Payout ID']):
        for record in records:
            formatted_records.append({
                'record_id': record['id'],
                'payout_id': record['fields']['Payout ID']                
            })
            table.delete(record['id'])

    return formatted_records