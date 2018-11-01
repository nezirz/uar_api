json.extract! item, :id, :name,:tag_list
json.total_records @items.total_entries
json.records_per_page Item.per_page
#json.url file_url(item, format: :json)
