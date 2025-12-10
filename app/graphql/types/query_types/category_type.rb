# frozen_string_literal: true

module Types
  class QueryTypes::CategoryType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :icon_name, String, null: true
    field :parent, QueryTypes::CategoryType, null: true
    field :children, [QueryTypes::CategoryType], null: true

    field :news_items_count, Integer, null: true
    field :news_items, [QueryTypes::NewsItemType], null: true

    # fields with optional location filter
    field :event_records_count, Integer, null: true, method: :event_records_count_by_location do
      argument :location, String, required: false
    end
    field :event_records, [QueryTypes::EventRecordType], null: true, method: :event_records_by_location do
      argument :location, String, required: false
    end
    field :upcoming_event_records_count, Integer, null: true, method: :upcoming_event_records_count_by_location do
      argument :location, String, required: false
    end
    field :upcoming_event_records, [QueryTypes::EventRecordType], null: true, method: :upcoming_event_records_by_location do
      argument :location, String, required: false
    end

    field :generic_items_count, Integer, null: true, method: :generic_items_count_by_location do
      argument :location, String, required: false
    end
    field :generic_items, [QueryTypes::GenericItemType], null: true, method: :generic_items_by_location do
      argument :location, String, required: false
    end

    field :points_of_interest_count, Integer, null: true, method: :points_of_interest_count_by_location do
      argument :location, String, required: false
    end
    field :points_of_interest, [QueryTypes::PointOfInterestType], null: true, method: :points_of_interest_by_location do
      argument :location, String, required: false
    end
    field :points_of_interest_tree_count, Integer, null: true do
      argument :location, String, required: false
      argument :data_provider_ids, [ID], required: false
      
      def resolve(location: nil, data_provider_ids: nil)
        args = {}
        args[:location] = location if location.present?
        args[:data_provider_ids] = data_provider_ids if data_provider_ids.present?
        object.points_of_interest_tree_count(args.present? ? args : nil)
      end
    end

    field :tours_count, Integer, null: true, method: :tours_count_by_location do
      argument :location, String, required: false
    end
    field :tours, [QueryTypes::TourType], null: true, method: :tours_by_location do
      argument :location, String, required: false
    end
    field :tours_tree_count, Integer, null: true do
      argument :location, String, required: false
      argument :data_provider_ids, [ID], required: false
      
      def resolve(location: nil, data_provider_ids: nil)
        args = {}
        args[:location] = location if location.present?
        args[:data_provider_ids] = data_provider_ids if data_provider_ids.present?
        object.tours_tree_count(args.present? ? args : nil)
      end
    end

    field :tag_list, String, null: true

    field :contact, QueryTypes::ContactType, null: true
  end
end
