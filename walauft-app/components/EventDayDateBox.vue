<template>
  <li class="event-day-date-wrapper" ref="day">
    <div class="event-day-date box-with-dropshadow">
      <slot> </slot>
    </div>
  </li>
</template>

<style lang="scss" scoped>
.event-day-date-wrapper {
  top: -1px;
  padding-top: calc(1rem + 1px);
  position: sticky;

  .event-day-date {
    font-size: 1.5rem;
    position: sticky;
    top: 1rem;
  }
}

</style>