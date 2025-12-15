
'use strict';

/**
 * todo controller
 */

const { createCoreController } = require('@strapi/strapi').factories;
//exorting 
module.exports = createCoreController('api::todo.todo');