# Views
CardView = Backbone.Marionette.ItemView.extend(
  template: JST['row_template']
  tagName: 'tr'
)

CardsView = Backbone.Marionette.CompositeView.extend(
  tagName: 'table'
  className: 'table table-condensed table-striped'
  template: JST['grid_template']
  childView: CardView

  collectionEvents:
    'sync' : 'render'


  appendHtml: (collectionView, itemView) ->
    collectionView.$('tbody').append itemView.el
)

# Models and Collections

Card = Backbone.Model.extend(urlRoot: '/api/v1/cards')

CardCollection = Backbone.Collection.extend(
  url: '/api/v1/cards'
  model: Card)

$ ->
  CardTable = Backbone.Marionette.ItemView.extend(
    template: false
    el: '#buy-list'

    ui:
      quantity: 'input[name="card[quantity]"]'
      deleteButton: '[data-delete-card]'

    events:
      'blur @ui.quantity': 'updateQuantity'
      'click @ui.deleteButton': 'destroyCard'

    initialize: ->
      @buy_list_id = @$el.data('id')
      @cards = new CardCollection()
      @cards.fetch(data: { card: { buy_list_id: @buy_list_id } } )
      @cardsView = new CardsView(collection: @cards)
      @$el.append @cardsView.el
      @getTotalPrice(@buy_list_id)

    updateQuantity: (event) ->
      quantity = $(event.currentTarget).val()
      id = $(event.currentTarget).attr('id')
      card = new Card(id: id)
      $('input[name="card[quantity]"]').prop('disabled', true)
      card.save { quantity: quantity },
        success: =>
          @cards.fetch
            data: { card: { buy_list_id: @buy_list_id } }
            success: =>
              @getTotalPrice(@buy_list_id)

    getTotalPrice: (id) ->
      $.ajax
        url: "/api/v1/buy_lists/#{id}/total_price"
        type: 'get'
        dataType: 'json'

        success: (data) ->
          $('.total-usd-price').text(data.usd_price_formatted)
          $('.total-clp-price').text(data.clp_price_formatted)

    destroyCard: (event) ->
      id = $(event.currentTarget).data('delete-card')
      card = new Card(id: id)
      $('input').prop('disabled', true)
      card.destroy
        success: =>
          @cards.fetch
            data: { card: { buy_list_id: @buy_list_id } }
            success: =>
              @getTotalPrice(@buy_list_id)
  )

  cardTable = new CardTable()
