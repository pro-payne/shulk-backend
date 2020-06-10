<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSubcategoryProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subcategory_products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->text('products')->nullable();
            $table->bigInteger('subcategory_id')->unsigned();;
            $table->foreign('subcategory_id')->references('id')->on('sub_categories');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('subcategory_products');
    }
}
