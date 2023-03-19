# Pin npm packages by running ./bin/importmappin'application',preload:true
#pin "map",preload:true
pin'application',preload:true
pin "weather",preload:true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
pin_all_from "app/javascript/controllers", under: "controllers"
