# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils vala autotools-utils bzr

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://launchpad.net/gala"
EBZR_REPO_URI="lp:gala"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	>=pantheon-base/plank-0.3
	>=x11-libs/granite-0.3
	x11-libs/bamf
	>=x11-libs/gtk+-3.4:3
	>=x11-wm/mutter-3.8.4
	gnome-base/gnome-desktop:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch_user

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		VALAC="${VALAC}"
	)
	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
