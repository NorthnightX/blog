<template>
  <div class="input-container">
    <span class="input-label">{{ label }}</span>
    <el-input @focus="showBorder" @blur="hideBorder"
              style="width: 100%;padding-bottom: 10px" v-model="inputValue"></el-input>
    <div class="buttons" v-show="showButtons">
      <slot name="buttons"></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    label: String,
    value: String
  },
  data() {
    return {
      inputValue: this.value,
      showButtons: false,

    };
  },
  methods: {
    showBorder() {
      this.showButtons = true;
    },
    hideBorder() {
      this.showButtons = false;
    }
  }
};
</script>

<style scoped>
.input-container {
  position: relative;
  transition: border 0.3s;
  margin-top: 20px;
}

.input-container:focus-within {
  width: 70%;
  border: 1px solid #1890ff;
  border-radius: 4px;
  padding: 8px;
}

.input-container >>> .el-input__inner {
  width: 70%;
  border-radius: 0;
  border-top-width: 0;
  border-left-width: 0;
  border-right-width: 0;
  border-bottom-width: 1px;
}

.input-label {
  color: dimgrey;
  font-size: 14px;
}
</style>
