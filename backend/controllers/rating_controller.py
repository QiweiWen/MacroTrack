from flask import render_template, request, redirect, make_response

from base_controller import BaseController

from models.rating import Rating
import config
import json

class RatingController(BaseController):

  @BaseController.requires_auth
  def post(self):
    data = json.loads(request.data)

    Rating().new_rating(self.get_user_id(), data["recipe"], data["score"])

    return "Success!"
