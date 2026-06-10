# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Elementary Monitor"
HOMEPAGE="https://github.com/elementary/monitor"
SRC_URI="https://github.com/elementary/monitor/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/monitor-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Optional features from meson_options.txt
IUSE="video_cards_nvidia wingpanel-indicator"

# Build-time dependencies (map from upstream README)
DEPEND="
    dev-lang/sassc
    $(vala_depend)
    sys-devel/gettext
    virtual/pkgconfig
    dev-libs/libgee:0.8
    dev-libs/granite:7
    gnome-base/libgtop:2
    gui-libs/libadwaita:1
    sys-apps/flatpak
    dev-libs/json-glib
    sys-fs/udisks:2
    gui-libs/gtk:4
    dev-libs/livechart
    video_cards_nvidia? ( x11-drivers/nvidia-drivers )
    wingpanel-indicator? ( pantheon-base/wingpanel x11-libs/gtk+:3 )
"

# Runtime dependencies
RDEPEND="
    dev-libs/glib:2
    dev-libs/granite:7
    dev-libs/libgee:0.8
    gui-libs/libadwaita:1
    dev-libs/json-glib
    sys-fs/udisks:2
    sys-apps/flatpak
    gui-libs/gtk:4
    dev-libs/livechart
    video_cards_nvidia? ( x11-drivers/nvidia-drivers )
    wingpanel-indicator? ( pantheon-base/wingpanel x11-libs/gtk+:3 )
"

src_configure() {
	local meson_args=(
		"-Dindicator-wingpanel=$(usex wingpanel-indicator enabled disabled)"
		"-Dnvidia=$(usex video_cards_nvidia enabled disabled)"
	)

	meson_src_configure "${meson_args[@]}"
}

src_prepare() {
	default
	eapply "${FILESDIR}/${P}-add-nvidia-feature.patch"
	vala_setup
}
