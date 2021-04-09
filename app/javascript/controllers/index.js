// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
let context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

context = require.context("./product", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

context = require.context("./category", true, /_controller\.js$/)
application.load(definitionsFromContext(context))