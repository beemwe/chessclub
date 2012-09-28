require 'dragonfly/rails/images'

app = Dragonfly[:images]

app.configure_with(:imagemagick)
app.configure_with(:rails)
